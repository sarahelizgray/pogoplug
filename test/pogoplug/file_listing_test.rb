require_relative 'helper'

module PogoPlug
  class FileListingTest < Test::Unit::TestCase
    context "FileListing" do
      setup do
        @size = 2
        @offset = 0
        @file_listing = FileListing.new(size: @size, offset: @offset, total_count: @size)
      end

      should "provide the number of files in the listing" do
        assert_equal(@size, @file_listing.size)
      end

      context "from_json" do
        should "produce a FileListing instance when given JSON" do
          json = %q{
            {
              "files": [
                {
                  "fileid": "AnonCRwPRDGnAnaAnD1aHg",
                  "type": "1",
                  "name": "Folder One",
                  "parentid": "0",
                  "mimetype": "",
                  "size": "0",
                  "ctime": "1376082451582",
                  "mtime": "1376082451582",
                  "origtime": "1376082451582",
                  "xcstamp": "",
                  "tnstamp": "",
                  "mdstamp": "",
                  "streamtype": "full",
                  "thumbnail": "",
                  "preview": "",
                  "stream": "",
                  "livestream": "",
                  "flvstream": "",
                  "properties": {
                    "origin": ""
                  },
                  "metaver": "0",
                  "filename": "Folder One",
                  "mediatype": ""
                },
                {
                  "fileid": "WJ0I39hPZfSIgLYSes5u0w",
                  "type": "0",
                  "name": "bar.txt",
                  "parentid": "0",
                  "mimetype": "text/plain",
                  "size": "0",
                  "ctime": "1376082434000",
                  "mtime": "1376082434000",
                  "origtime": "1376082434000",
                  "xcstamp": "",
                  "tnstamp": "",
                  "mdstamp": "",
                  "streamtype": "full",
                  "thumbnail": "",
                  "preview": "",
                  "stream": "",
                  "livestream": "",
                  "flvstream": "",
                  "properties": {
                    "origin": ""
                  },
                  "metaver": "0",
                  "filename": "bar.txt",
                  "mediatype": "text"
                },
                {
                  "fileid": "fb1Ker1AetW8139ZhbPGDQ",
                  "type": "0",
                  "name": "foo.txt",
                  "parentid": "0",
                  "mimetype": "text/plain",
                  "size": "0",
                  "ctime": "1376082428000",
                  "mtime": "1376082428000",
                  "origtime": "1376082428000",
                  "xcstamp": "",
                  "tnstamp": "",
                  "mdstamp": "",
                  "streamtype": "full",
                  "thumbnail": "",
                  "preview": "",
                  "stream": "",
                  "livestream": "",
                  "flvstream": "",
                  "properties": {
                    "origin": ""
                  },
                  "metaver": "0",
                  "filename": "foo.txt",
                  "mediatype": "text"
                },
                {
                  "fileid": "nZaBs2cdLUKQOu_vvFxn2w",
                  "type": "1",
                  "name": "Folder Two",
                  "parentid": "0",
                  "mimetype": "",
                  "size": "0",
                  "ctime": "1376082458122",
                  "mtime": "1376082458122",
                  "origtime": "1376082458122",
                  "xcstamp": "",
                  "tnstamp": "",
                  "mdstamp": "",
                  "streamtype": "full",
                  "thumbnail": "",
                  "preview": "",
                  "stream": "",
                  "livestream": "",
                  "flvstream": "",
                  "properties": {
                    "origin": ""
                  },
                  "metaver": "0",
                  "filename": "Folder Two",
                  "mediatype": ""
                }
              ],
              "pageoffset": "0",
              "count": "4",
              "totalcount": "4"
            }
          }
          listing = FileListing.from_json(JSON::parse(json))
          assert_equal(4, listing.size, "Size does not match")
          assert_equal(0, listing.offset, "Offset does not match")
          assert_equal(4, listing.total_count, "Total count does not match")
          assert_not_nil(listing.files, "Files are missing")
          assert_kind_of(Enumerable, listing.files)
          assert_equal(4, listing.files.size, "Expected 4 files")
          assert_false(listing.empty?)
        end

        should "produce a file listing from json returned for empty folder" do
          json = "{\"pageoffset\":\"0\",\"count\":\"0\",\"totalcount\":\"0\"}"
          listing = FileListing.from_json(JSON::parse(json))

          assert_equal(0, listing.size, "Size does not match")
          assert_equal(0, listing.offset, "Offset does not match")
          assert_equal(0, listing.total_count)
          assert_true(listing.empty?, "Should be empty")
        end
      end
    end
  end
end
