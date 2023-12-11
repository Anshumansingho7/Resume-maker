require 'prawn'
require 'rqrcode'
require 'chunky_png'

# oops concepts
# class, object, -----n  --Include, extend, overload, overwrite, cunstructor

def generate_qr_code(url)
    begin
      qrcode = RQRCode::QRCode.new(url, size: 5, level: :h)
      png = qrcode.as_png(resize_gte_to: false, resize_exactly_to: false)
      ChunkyPNG::Image.from_datastream(png.to_datastream)
    rescue StandardError => e
     puts "Error generating QR code: #{e.message}"
     return nil
    end
  end  
  
def generate_pdf_with_qr_code(url, pdf_path)
    qr_code_image = generate_qr_code(url)

    return unless qr_code_image

    #Save data to a PDF file
    Prawn::Document.generate(pdf_path) do
        image 'Instagram_logo_2016.svg.png', at: [-20,740], width: 50, height: 50


        image StringIO.new(qr_code_image.to_blob),at: [520, 740], width: 50, height: 50
        puts "Enter your Name: "
        name = gets.chomp
        move_down 40
        text name.upcase, size: 30
        loop do 
            puts "would you like to add Something more?(y/n)"
            z = gets.chomp
            if z === "y"
                print "Enter  : "
                something = gets.chomp

                move_down 20
                text something.upcase
    
                loop do 
                    puts "would you like to add a line in this?(y/n)"
                    line = gets.chomp
                    if line === "y"
                        bounding_box([0, cursor], width: bounds.width, height: 1) do
                            stroke_color '000000' # Black color
                            line_width 0.5          # Line width in points
                        
                            # Draw a line from the left to the right of the bounding box
                            stroke_horizontal_rule
                        end
                    elsif line === "n"
                        break
                    else
                        puts "please fill y or n"
                    end
                end
                
                loop do 
                    puts "would you like to add SomeDiscription Heading about this?(y/n)"
                    u = gets.chomp
                    if u === "y"
                        print "Enter description Heading: "
                        description_heading = gets.chomp
                        
                        move_down 15
                        text "      #{description_heading}"
                        move_down 15
                        loop do 
                            puts "would you like to add some Discription  about this?(y/n)"
                            line = gets.chomp
                            if line === "y"
                                print "Enter description:"
                                description = gets.chomp
                                move_down 10
                                text ".  #{description}"
                                move_down 10
                            elsif line === "n"
                                break
                            else
                                puts "please fill y or n"
                            end
                        end
                    elsif u === "n"
                        break
                    else
                        puts "please fill y or n"
                    end
                end
                
            elsif z === "n"
                break
            else
                puts "please fill y or n "
            end
        end
    end

    puts "Resume saved to resume1.pdf"

end

url = 'https://www.webkorps.com/#/'
pdf_path = 'resume1.pdf'

generate_pdf_with_qr_code(url, pdf_path)