class MovieDisplay < GenericDisplayer
  def method_missing(meth, *args, &block)
    movie.send(meth, *args, &block)
  end

  def as_json(options = {})
    movie.as_json
  end
end
