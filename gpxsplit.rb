require 'nokogiri'
require 'time'

if ARGV.length != 1
  puts 'Usage: gpxsplit.rb YOURBIGGPXFILE'
  exit 1
end

outdir = File.basename(ARGV[0], '.*')
Dir.mkdir(outdir) unless Dir.exist?(outdir)

doc = Nokogiri::XML(File.read(ARGV[0]))

gpx_version = doc.at_xpath('/*/@version')&.value
doc.remove_namespaces!

doc.xpath('//trkseg').each do |seg|
  first_pt_time = seg.at_xpath('.//time')&.text
  next unless first_pt_time

  jst_time = Time.parse(first_pt_time).getlocal('+09:00')
  filename = jst_time.strftime('%Y%m%d_%H%M%S.gpx')

  builder = Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
    xml.gpx(version: gpx_version, creator: 'GPXSplit', xmlns: 'http://www.topografix.com/GPX/1/0') do
      xml.trk do
        xml.name jst_time.strftime('%Y/%m/%d %H:%M:%S (JST)')
        xml << seg.to_xml
      end
    end
  end

  File.write(File.join(outdir, filename), builder.to_xml)
  puts "Generated: #{filename}"
end
