module ApplicationHelper
  def pagify(page, count, path, parameters)
    str = ''
    logger.info "Page: #{page} Count: #{count} Path: #{path} Parameters: #{parameters}"
    if count > 1
      str+=link_to('<<', self.send(path, parameters.merge(page: 1)))
      5.times do |i|
        current = page-2+i
        next unless current.between?(1, count)
        pagestr = " #{current} "
        if current == page
          str+=pagestr
        else
          str+=link_to(
              pagestr,
              self.send(path, parameters.merge(page: current))
          )
        end
      end
      str+=link_to('>>', self.send(path, parameters.merge(page: count)))
    end
    logger.info "Str is #{str}"
    return str.html_safe
  end
end
