class MovieDisplay < GenericDisplayer
  def method_missing(meth, *args, &block)
    movie.send(meth, *args, &block)
  end
end
