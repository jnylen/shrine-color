$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'shrine'
require 'shrine/plugins/add_metadata'
require 'shrine/plugins/color'
require 'shrine/storage/file_system'

def uploader(storage_key = :store, &block)
  uploader_class = Class.new(Shrine)
  uploader_class.storages[:cache] = Shrine::Storage::FileSystem.new("/tmp", prefix: "uploads")
  uploader_class.storages[:store] = Shrine::Storage::FileSystem.new("/tmp", prefix: "uploads")
  uploader_class.class_eval(&block) if block
  uploader_class.new(storage_key)
end

def attacher(*args, &block)
  uploader = uploader(*args, &block)
  Object.send(:remove_const, "User") if defined?(User) # for warnings
  user_class = Object.const_set("User", Struct.new(:avatar_data, :id))
  user_class.include uploader.class[:avatar]
  user_class.new.avatar_attacher
end
