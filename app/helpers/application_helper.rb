module ApplicationHelper
  def pagify(page, count, path, parameters)
    str = ''
    if count > 1
      str+=link_to('<<', self.send(path, parameters.merge(:page => 1)))
      num = 5
      (num*2+1).times do |i|
        current = page-num+i
        next unless current.between?(1, count)
        pagestr = " #{current} "
        if current == page
          str+=pagestr
        else
          str+=link_to(
              pagestr,
              self.send(path, parameters.merge(:page => current))
          )
        end
      end
      str+=link_to('>>', self.send(path, parameters.merge(:page => count)))
    end
    return str.html_safe
  end
end
