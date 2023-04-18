class ApplicationService
  class Result
    attr_accessor :errors, :result

    def initialize(params)
      @result = params[:result]
      @errors = params[:errors]
    end
  end

  def initialize(...); end

  def self.call(*args, &block)
    new(*args).call(&block)
  end

  def call
    return unless block_given?
    # можно написать отправку мейлеров и тд
    true
  end

  def transaction_commit!
    return unless block_given?

    begin
      ActiveRecord::Base.transaction do
        yield
      end
    rescue ActiveRecord::RecordInvalid => invalid
      invalid.record
    end
  end

  private_class_method(:new)
end