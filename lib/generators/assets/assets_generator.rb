require 'rails/generators/rails/assets/assets_generator'

module NestedScaffold
  module Generators
    class AssetsGenerator < ::Rails::Generators::AssetsGenerator
      source_root superclass.source_root
    end
  end
end
