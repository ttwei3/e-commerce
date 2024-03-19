# app/admin/static_pages.rb
ActiveAdmin.register StaticPage do
  actions :all
  permit_params :title, :content, :identifier

  index do
    selectable_column
    id_column
    column :title
    column :identifier
    actions
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :identifier, input_html: { disabled: true }
      f.input :content, as: :text
    end
    f.actions
  end

  before_create do |page|
    page.identifier = page.identifier.downcase
  end

  controller do
    def find_resource
      scoped_collection.find_by!(identifier: params[:id])
    end
  end

  filter :title
  filter :content
  filter :identifier
end
