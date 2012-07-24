require 'tempfile'

class AnnotationTests < Test::Unit::TestCase
  TEST_APP = "#{TEST_PATH}/apps/rails2"

  def with_temp_file name
    annotation_file = Tempfile.new name
    annotation_file.close

    yield annotation_file

    annotation_file.unlink
  end

  def test_annotations_with_format
    with_temp_file 'annotation' do |file|

      original_report = Brakeman.run(:app_path => TEST_APP,
                                     :output_format => :annotations,
                                     :output_files => [file.path])

      ignored_report = Brakeman.run(:app_path => TEST_APP,
                                    :annotations_file => file.path)

      assert_equal 0, ignored_report.checks.all_warnings.length
    end
  end

  def test_annotations_with_file
    with_temp_file ['annotation', '.annotations'] do |file|

      original_report = Brakeman.run(:app_path => TEST_APP,
                                     :output_files => [file.path])

      ignored_report = Brakeman.run(:app_path => TEST_APP,
                                    :annotations_file => file.path)

      assert_equal 0, ignored_report.checks.all_warnings.length
    end
  end
end
