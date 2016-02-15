class AlbumDecorator < Draper::Decorator
  delegate_all

  def contacted_status #decorators are used only in view, this allows me to keep logic out of the ERB files.
    object.published? ? "Customer has been sent album" : "Awaiting approval"
  end
end
