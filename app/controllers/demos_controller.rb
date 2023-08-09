class DemosController < ApplicationController
  def show
    file = Rails.root.join("demo.txt")
    FileUtils.touch(file) unless File.exist?(file)
    @content = File.read(file)
  end

  def update
    new_line = params["something"]

    file = Rails.root.join("demo.txt")
    File.open(file, "a") do |file|
      file.puts(new_line)
    end

    respond_to do |format|
      format.turbo_stream do
        @content = File.read(file)
        render turbo_stream: turbo_stream.replace(
          "the_entire_page",
          partial: "demos/page"
        )
      end
      format.html do
        puts "Using HTML"
        redirect_to demo_path
      end
    end
  end
end
