require 'barby'
require 'barby/barcode/ean_13'
require 'barby/barcode/ean_8'
require 'barby/outputter/svg_outputter'
require 'barby/outputter/ascii_outputter'

module BarcodeHelper

  def barcode(id, options = {})
    raw "<div id='barcode'><p>#{barcode_id(id)}</p>#{barcode_svg(id, options)}</div>"
  end

  #---------------------------------------------------------------------------
  private

  # Generate the SVG for an EAN8 barcode corresponding to the given ID.
  # @param [Fixnum] id the ID to be encoded as a barcode.
  # @return [String] SVG barcode.
  #
  def barcode_svg(id, options = {})
    height = options[:height] || 15
    scale  = options[:scale]  ||  1
    barcode = Barby::EAN8.new(id.to_s.rjust(7, '0'))
    output = Barby::SvgOutputter.new(barcode)
    output.height = height
    output.xdim   = scale
    output.margin = 0
    output.to_svg
  end

  def barcode_id(id)
    id = id.to_s
    groups = [id[0..2], id[3..4], id[5..7]]
    string = ''
    groups.each { |group| string << "<span class='group'>#{group}</span>" }
    string
  end
end
