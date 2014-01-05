=begin rdoc

ActiveRecordImportQueue will maintain a list of ActiveRecord objects and use
the activerecord-import '.import' extension to import them in to a database
in bulk.

=end

class ActiveRecordImportQueue

=begin rdoc

Create a new instance of the import queue.

Specify 'limit=n' to limit the number of queued records to the value 'n'. 
This limit will be checked each time an object is queued.

=end

  def initialize(params={ :limit => 100 })
    @pending = {}
    @count = 0
    @params = params
  end

=begin rdoc

Returns the total number of pending objects.

=end

  def count_pending
    @count
  end

=begin rdoc

To queue a new object, use the '<<' method to push an ActiveRecord object on
to the queue.

=end

  def <<(obj)
    @pending[obj.class] ||= []
    @pending[obj.class] << obj
    incr_count
    check_depth
  end

=begin rdoc

Imports all queued objects irrespective of whether the queue limit has been
reached.  This should be used at the end of an import run to insert remaining
objects in to the database.

=end

  def finish
    @pending.keys.collect { |klass| process_class(klass) }
  end

  private

  def incr_count
    @count += 1
  end

  def decr_count
    @count -= 1
  end

  def process_class(klass)
    klass.import(@pending[klass])
    @pending[klass] = []
  end

  def check_depth
    @pending.keys.collect { |klass| process_class(klass) if @pending[klass].count > @params[:limit] }
  end

end
