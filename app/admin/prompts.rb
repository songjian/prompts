ActiveAdmin.register Prompt do
  permit_params :content

  index do
    selectable_column
    id_column
    column :content do |prompt|
      truncate(prompt.content, length: 100)
    end
    column :created_at
    column :updated_at
    column :versions do |prompt|
      prompt.versions.count
    end
    actions
  end

  form do |f|
    f.inputs do
      f.input :content
    end
    f.actions
  end

  show do
    attributes_table do
      row :content do |prompt|
        div id: "prompt-content-#{prompt.id}" do
          pre style: "white-space: pre-wrap;" do
            prompt.content
          end
        end
        button_tag "复制", type: "button", class: "copy-button", data: { target: "prompt-content-#{prompt.id}" }
      end
    end
  end

  # show do
  #   attributes_table do
  #     row :id
  #     row :content
  #     row :created_at
  #     row :updated_at
  #   end

  #   panel "版本历史" do
  #     table_for prompt.versions.reverse do
  #       column("版本") { |v| v.index + 1 }
  #       column("修改时间") { |v| v.created_at }
  #       column("操作者") { |v| v.whodunnit }
  #       column("更改内容") { |v| v.changeset }
  #     end
  #   end

    # 在 ActiveAdmin 中显示版本 diff
      # panel "版本差异" do
      #   if prompt.versions.size >= 2
      #     diff = Diffy::Diff.new(
      #       prompt.versions[-2].reify.content,
      #       prompt.content,
      #       context: 2
      #     ).to_s(:html)
      #     div do
      #       raw(diff)
      #     end
      #   end
      # end
  # end

  controller do
    def update
      # 设置当前用户为修改者（配合 paper_trail）
      PaperTrail.request.whodunnit = current_admin_user.id
      super
    end

    def create
      PaperTrail.request.whodunnit = current_admin_user.id
      super
    end
  end
end
