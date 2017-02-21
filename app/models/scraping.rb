class Scraping
  def self.movie_urls
    links = []
    agent = Mechanize.new
    next_url = ""

    while true
      current_page = agent.get("http://review-movie.herokuapp.com/" + next_url)
      elements = current_page.search('.entry-title a')
      elements.each do |ele|
        links << ele.get_attribute('href')
      end

      next_link = current_page.at('.pagination .next a')
      break unless next_link
      next_url = next_link.get_attribute('href')

    end
    links.each do |link|
      get_product('http://review-movie.herokuapp.com' + link)
    end
  end

  def self.get_product(link)
    agent = Mechanize.new
    page = agent.get(link)
    title = page.at('.entry-title').inner_text if page.at('.entry-title')
    image_url = page.at('.entry-content img')[:src] if page.at('.entry-content img')
    product = Product.where(title: title).first_or_initialize
    product.image_url = image_url
    product.save
  end
end




# class Scraping
#       def self.movie_urls
#        links = [] #①linksという配列の空枠を作る
#         agent = Mechanize.new#②Mechanizeクラスのインスタンスを生成する
#         current_page = agent.get("http://review-movie.herokuapp.com/") #③映画の全体ページのURLを取得
#         elements = current_page.serach('.entry-title a')
#         elments.each do|ele|
#           links << ele.get_attiribute('href')
#         end

#         links.each do |link|
#          get_prodact('http://review-movie.herokuapp.com' + link)
#          end#
#       end

#       def self.get_product(link)
#         agent = Mechanize.new#⑦Mechanizeクラスのインスタンスを生成する
#         page = agent.get(link)
#         title = page.at('.entry-title').inner_text
#         image_url = page.at('.entry-content img')[:src] if page.at('.entry-content img')
#         product = Product.new(title: title, image_url: image_url)
#         product.save#
#       end
#     end