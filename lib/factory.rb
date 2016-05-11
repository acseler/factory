# Factory class
class Factory
  def self.new(*args, &block)
    first = args[0]
    args.shift if first.is_a?(String) && first[0].match(/[[:upper:]]/).size == 1

    cls = generate_class(*args, &block)

    if args.include?(first)
      cls
    else
      const_set(first, cls)
    end
  end

  def self.generate_class(*args, &block)
    Class.new do

      attr_accessor(*args)
      define_method 'initialize' do |*arguments|
        arguments.each_with_index do |item, index|
          send("#{args[index]}=", item)
        end
      end

      define_method '[]' do |val_index|
        val_index.is_a?(Fixnum) ? send(args[val_index]) : send(val_index)
      end

      define_method '[]=' do |val_index, set_val|
        if val_index.is_a?(Fixnum)
          send("#{args[val_index]}=", set_val)
        else
          send("#{val_index}=", set_val)
        end
      end

      define_method 'to_a' do
        args.inject([]) do |arr, item|
          arr << send(item)
        end
      end

      define_method 'to_h' do
        Hash[args.zip to_a]
      end

      define_method 'length' do
        args.size
      end

      class_eval do
        alias_method :size, :length
        alias_method :values, :to_a
      end

      class_eval(&block) if block_given?
    end
  end
end
