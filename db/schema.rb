ActiveRecord::Schema.define(version: 20150903111436) do

  create_table "links", force: :cascade do |t|
    t.string   "url"
    t.string   "slug"
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
