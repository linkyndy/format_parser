class FormatParser::PSDParser
  PSD_HEADER = [0x38, 0x42, 0x50, 0x53]
  include FormatParser::IOUtils

  def information_from_io(io)
    io.seek(0)
    magic_bytes = safe_read(io, 4).unpack("C4")

    return unless magic_bytes == PSD_HEADER

    # We can be reasonably certain this is a PSD so lets grab the height
    # and width bytes
    w,h = safe_read(io, 22).unpack("x10N2")
    return FormatParser::FileInformation.new(width_px: w, height_px: h)
  end

end