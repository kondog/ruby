class Tree 
    class Node
        attr_accessor :key, :value, :children
        def initialize( key, value )
            @key = key; @value = value; @children = []
        end
    end

    attr_accessor :root
    def initialize()
        @root = nil
    end

    def add!( key, value, parent_key = "", node = @root )
        if @root == nil
            @root = Node.new( key, value )
        elsif node.key == parent_key
            node.children << Node.new( key,value )
            node.children.sort! { |a,b| a.key <=> b.key}
        else
            node.children.each do |child|
                self.add!( key, value, parent_key, child )
            end
        end
    end

    def depth( depth = 1, node = @root, max_depth = 0 )
        if node.children == []
            return depth
        else
            node.children.each do |child|
                each_max = self.depth( depth+1, child, max_depth )
                if each_max != nil
                    max_depth = each_max if max_depth < each_max
                end
            end
        end
        return max_depth
    end

    def output( all_line = [], depth = 0, max_depth = (self.depth)*2, node = @root )
        line          = [nil] * max_depth
        line[depth]   = node.key
        line[depth+1] = node.value
        all_line << line
        node.children.each do |child| 
            self.output( all_line, depth+2, max_depth, child )
        end
        return all_line if node == @root
    end
end
