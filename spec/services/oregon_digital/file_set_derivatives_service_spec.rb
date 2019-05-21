# frozen_string_literal:true

require 'hyrax/specs/shared_specs'

RSpec.describe OregonDigital::FileSetDerivativesService do
  subject { service }

  let(:service) { described_class.new(valid_file_set) }
  let(:mime_type) { 'image/tiff' }
  let(:uri) { 'http://example.org/1/2/3/foo' }
  let(:valid_file_set) do
    FileSet.new.tap do |f|
      allow(f).to receive(:mime_type).and_return(mime_type)
      allow(f).to receive(:uri).and_return(uri)
    end
  end

  it_behaves_like 'a Hyrax::DerivativeService'

  describe '#create_derivatives' do
    [
      [FileSet.pdf_mime_types,             :create_pdf_derivatives],
      [FileSet.office_document_mime_types, :create_office_document_derivatives],
      [FileSet.audio_mime_types,           :create_audio_derivatives],
      [FileSet.video_mime_types,           :create_video_derivatives],
      [FileSet.image_mime_types,           :create_image_derivatives]
    ].each do |mimes, callee|
      mimes.each do |mime|
        context "with a #{mime} source" do
          let(:mime_type) { mime }
          let(:callee) { callee }

          it "runs #{callee}" do
            allow(service).to receive(callee).and_return true
            expect(service).to receive(callee).once
            service.create_derivatives('bogus/file/path')
          end
        end
      end
    end
  end

  describe '#sorted_derivative_urls' do
    let(:dpf) { instance_double('Hyrax::DerivativePathFactory') }
    let(:ext) { 'jp2' }
    let(:path1) { 'zoomable.jp2' }
    let(:path2) { 'thumbnail.jpg' }
    let(:path3) { 'page2.jp2' }

    before do
      allow(service).to receive(:derivative_path_factory).and_return dpf
      allow(dpf).to receive(:derivative_path_for_reference).with(valid_file_set, ext).and_return "foo.#{ext}"
      allow(dpf).to receive(:derivatives_for_reference).with(valid_file_set).and_return([path1, path2, path3])
    end

    # Rubocop won't let us make two expectations, otherwise this would just be
    # part of the "only returns files with the expected extension" test
    it 'returns the right number of files' do
      expect(service.sorted_derivative_urls(ext).length).to eq(2)
    end

    it 'only returns files with the expected extension' do
      expect(service.sorted_derivative_urls(ext)).to all(match(/\.#{ext}\Z/))
    end

    it 'sorts the results' do
      urls = service.sorted_derivative_urls(ext)
      expect(urls).to eq(urls.sort)
    end

    it 'prefixes the paths' do
      expect(service.sorted_derivative_urls(ext)).to all(match(%r{\Afile://}))
    end
  end

  describe '#create_image_derivatives' do
    let(:bogus_jpg) { '/bogus/path/to/file.jpg' }
    let(:tmp_bmp) { '/tmp/path/to/file.bmp' }

    before do
      allow(OregonDigital::Derivatives::Image::Utils).to receive(:tmp_file).with('bmp').and_yield(tmp_bmp)
      allow(service).to receive(:preprocess_image)
      allow(service).to receive(:create_thumbnail)
      allow(service).to receive(:create_zoomable)
    end

    it 'preprocesses the image' do
      expect(service).to receive(:preprocess_image).with(bogus_jpg, tmp_bmp)
      service.create_image_derivatives(bogus_jpg)
    end

    it 'creates a thumbnail from the bitmap' do
      expect(service).to receive(:create_thumbnail).with(tmp_bmp)
      service.create_image_derivatives(bogus_jpg)
    end

    it 'creates a zoomable image from the bitmap' do
      expect(service).to receive(:create_zoomable).with(tmp_bmp)
      service.create_image_derivatives(bogus_jpg)
    end
  end

  describe '#preprocess_image' do
    let(:source) { '/bogus/path/to/file.xyzzy' }
    let(:tmp_bmp) { '/tmp/path/to/file.bmp' }

    context 'with a JP2' do
      let(:mime_type) { 'image/jp2' }

      it 'runs the jp2 preprocessor to generate the bmp' do
        expect(service).to receive(:jp2_to_bmp).with(source, tmp_bmp)
        service.preprocess_image(source, tmp_bmp)
      end
    end

    context 'with a BMP' do
      let(:mime_type) { 'image/bmp' }

      it 'runs the bmp preprocessor to generate the bmp' do
        expect(service).to receive(:bmp_to_bmp).with(source, tmp_bmp)
        service.preprocess_image(source, tmp_bmp)
      end
    end

    (FileSet.image_mime_types - ['image/jp2', 'image/bmp']).each do |mime|
      context "with a #{mime}" do
        let(:mime_type) { mime }
        let(:minimagick) { double }

        before do
          allow(MiniMagick::Image).to receive(:open).with(source).and_return(minimagick)
          allow(minimagick).to receive(:format).with('bmp').and_return(minimagick)
          allow(minimagick).to receive(:write).with(tmp_bmp)
        end

        it 'runs minimagick to generate a bmp' do
          expect(minimagick).to receive(:write).with(tmp_bmp)
          service.preprocess_image(source, tmp_bmp)
        end
      end
    end
  end

  describe '#jp2_to_bmp' do
    let(:processor) { double }

    before do
      allow(service).to receive(:jp2_processor).and_return(processor)
      allow(processor).to receive(:opj_decompress).and_return('tool')
    end

    it "runs the processor's execute method" do
      expect(processor).to receive(:execute).with('tool -i foo.jp2 -o bar.bmp')
      service.jp2_to_bmp('foo.jp2', 'bar.bmp')
    end

    it 'escapes shell-dangerous source and destinations' do
      expect(processor).to receive(:execute).with('tool -i foo\"bar -o baz\ \|\|\ exit\ 1')
      service.jp2_to_bmp('foo"bar', 'baz || exit 1')
    end
  end

  describe '#bmp_to_bmp' do
    before do
      allow(File).to receive(:unlink).with('tmp.bmp')
      allow(FileUtils).to receive(:ln_s).with('orig.bmp', 'tmp.bmp')
    end

    it 'removes the temp file' do
      expect(File).to receive(:unlink).with('tmp.bmp')
      service.bmp_to_bmp('orig.bmp', 'tmp.bmp')
    end

    it 'symlinks the source bmp' do
      expect(FileUtils).to receive(:ln_s).with('orig.bmp', 'tmp.bmp')
      service.bmp_to_bmp('orig.bmp', 'tmp.bmp')
    end
  end

  describe '#create_pdf_derivatives' do
    let(:bogus_pdf) { '/bogus/path/to/file.pdf' }
    let(:tmp_bmp) { '/tmp/path/to/file.bmp' }
    let(:mime_type) { 'application/pdf' }
    let(:minimagick) { double }
    let(:pages) { [double, double, double, double, double] }

    before do
      allow(OregonDigital::Derivatives::Image::Utils).to receive(:tmp_file).with('bmp').and_yield(tmp_bmp)
      allow(service).to receive(:create_thumbnail)
      allow(service).to receive(:extract_full_text)
      allow(service).to receive(:manual_convert)
      allow(service).to receive(:create_zoomable_page)

      allow(MiniMagick::Image).to receive(:open).with(bogus_pdf).and_return(minimagick)
      allow(minimagick).to receive(:pages).and_return(pages)
    end

    it 'creates a thumbnail' do
      expect(service).to receive(:create_thumbnail).with(bogus_pdf)
      service.create_pdf_derivatives(bogus_pdf)
    end

    it 'generates OCR' do
      expect(service).to receive(:extract_full_text).with(bogus_pdf, uri)
      service.create_pdf_derivatives(bogus_pdf)
    end

    it 'converts each page to a bitmap' do
      pages.each_with_index do |_, i|
        expect(service).to receive(:manual_convert).with(bogus_pdf, i, tmp_bmp)
      end

      service.create_pdf_derivatives(bogus_pdf)
    end

    it "creates a zoomable image from each page's bitmap" do
      pages.each_with_index do |_, i|
        expect(service).to receive(:create_zoomable_page).with(tmp_bmp, i)
      end
      service.create_pdf_derivatives(bogus_pdf)
    end
  end

  describe '#manual_convert' do
    # This seems awful, but I want the free behaviors of an array, and rspec
    # won't let me just add :density to an array as an expectation unless the
    # method is already there
    let(:convert) do
      c = []
      c.define_singleton_method(:density) { |_| nil }
      c
    end

    # Make sure we're always calling the function in the same way
    let(:func) do
      proc { service.manual_convert('in.pdf', 4, 'out.tmp') }
    end

    before do
      allow(MiniMagick::Tool::Convert).to receive(:new).and_yield(convert)
    end

    it 'uses minimagick to generate a convert command' do
      expect(MiniMagick::Tool::Convert).to receive(:new).once
      func.call
    end

    it 'sets the PDF density to 300' do
      expect(convert).to receive(:density).with(300)
      func.call
    end

    it 'sets up the proper convert parameters' do
      func.call
      expect(convert).to eq(['in.pdf[4]', 'out.tmp'])
    end
  end

  describe '#create_thumbnail' do
    before do
      allow(OregonDigital::Derivatives::Image::GMRunner).to receive(:create)
    end

    it 'kicks off the Graphics Magick runner' do
      expect(OregonDigital::Derivatives::Image::GMRunner).to receive(:create).once
      service.create_thumbnail('file')
    end

    it 'calls derivative_url' do
      expect(service).to receive(:derivative_url).with('thumbnail')
      service.create_thumbnail('file')
    end
  end

  describe '#create_zoomable' do
    it 'delegates to create_zoomable_page with no page name' do
      filename = 'filename.jp2'
      expect(service).to receive(:create_zoomable_page).with(filename, nil).once
      service.create_zoomable(filename)
    end
  end

  describe '#create_zoomable_page' do
    before do
      allow(OregonDigital::Derivatives::Image::JP2Runner).to receive(:create)
    end

    it 'kicks off the JP2Runner' do
      expect(OregonDigital::Derivatives::Image::JP2Runner).to receive(:create).once
      service.create_zoomable_page('file', 4)
    end

    it 'calls derivative_url with a page number' do
      expect(service).to receive(:derivative_url).with('jp2', 4)
      service.create_zoomable_page('file', 4)
    end
  end
end
