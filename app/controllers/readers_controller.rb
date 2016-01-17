require 'net/http'
require 'uri'
require 'nokogiri'

class ReadersController < ApplicationController
  before_action :set_reader, only: [:show, :edit, :update, :destroy]

  # GET /readFormatHelper
  def formatHelper
    target_url = params.permit(:url)["url"]
    token = "e4a8c8fb7005519eaf713d2d38a042084557d859" # TODO: change token
    target_url = params.permit(:url)["url"]
    url = "http://readability.com/api/content/v1/parser?token=#{token}&url=#{target_url}"

    content = JSON Net::HTTP.get(URI.parse(url))
    content["version"] = '0.0.1'
    render json: content

    # @content = parse_content target_url
    # render :formater
  end

  # GET /list
  def list
    page = current_page
    uri = page == 1 ? "http://time.com/us/" : "http://time.com/us/page/#{page}"
    @html = load_html(uri)
    list_data = parse_list params[:site]

    render json: {
        success: true,
        list: list_data
    }
  end

  # GET /readers
  # GET /readers.json
  def index
    @readers = Reader.all
  end

  # GET /readers/1
  # GET /readers/1.json
  def show
  end

  # GET /readers/new
  def new
    @reader = Reader.new
  end

  # GET /readers/1/edit
  def edit
  end

  # POST /readers
  # POST /readers.json
  def create
    @reader = Reader.new(reader_params)

    respond_to do |format|
      if @reader.save
        format.html { redirect_to @reader, notice: 'Reader was successfully created.' }
        format.json { render :show, status: :created, location: @reader }
      else
        format.html { render :new }
        format.json { render json: @reader.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /readers/1
  # PATCH/PUT /readers/1.json
  def update
    respond_to do |format|
      if @reader.update(reader_params)
        format.html { redirect_to @reader, notice: 'Reader was successfully updated.' }
        format.json { render :show, status: :ok, location: @reader }
      else
        format.html { render :edit }
        format.json { render json: @reader.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /readers/1
  # DELETE /readers/1.json
  def destroy
    @reader.destroy
    respond_to do |format|
      format.html { redirect_to readers_url, notice: 'Reader was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reader
      @reader = Reader.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reader_params
      params[:reader]
    end

    def open_url(target_url)
      open(target_url,
           "User-Agent"=> 'Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/30.0.1599.17 Safari/537.36'
      )
    end

    def load_html target_url
      Nokogiri::HTML open_url(target_url)
    end

    def current_page
      page = 1
      page = params[:page].to_i if params[:page].to_i > 1
      page
    end

    def parse_list(site_name)
      currentPageData = []
      case site_name
        when 'time_us'
          @html.css('.section-archive-list__article').each do |element|
            itemData = {
                title: element.css('.section-article-title a').first.content,
                picture: element.css('figure a img').first.attr('src'), #.gsub(/(\?|%2C)[\w=&]*/i, ''),
                url: element.css('.section-article-title a').first.attr('href')
            }
            currentPageData.push itemData
          end
      end
      currentPageData
    end

    def parse_content(site_url)
      html = load_html site_url
      currentPageData = {}

      case site_url
        when /^https?:\/\/time\.com\//i
          content = html.css('.article-body .clipper-content').first.css('*')
                        .filter(':not([class^=right])')
                        .select {|x| !['param','object','footer'].include?(x.name) && !x.matches?('.time-icon')}
                        .map {|x| x.to_html}
                        .join('')

          currentPageData = {
              title: html.css('.article-header .article-title').first.content,
              author: html.css('.article-author').first.content,
              time: html.css('.publish-date').first.content,
              url: site_url,
              content: content
                  #html.css('.article-body').first.children.to_html,
          }
      end

      currentPageData
    end
end
