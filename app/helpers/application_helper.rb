# Helper, die überall benötigt werden
module ApplicationHelper
  # Generiert den Titel für die Seiten
  def full_title(page_title)
    base_title=I18n.t('misc.appname')
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  # Helper für die Umleitung auf eine „Sie haben keine Rechte“–Seite
  def have_no_rights(message)
    flash[:error]=I18n.t(message)
    redirect_to projects_path
  end

  def li(f)
    f.downcase 
  end
end
