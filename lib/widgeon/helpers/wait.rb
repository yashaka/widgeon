# original wait_until helper from https://gist.github.com/jnicklas/d8da686061f0a59ffdf7
# @return the "until" block result, which assumed to be the boolean answer to question - element became like wanted? or not?
def wait_until
  require "timeout"
  Timeout.timeout(Capybara.default_wait_time) do
    sleep(0.1) until value = yield
    value
  end
end

# accept two lambdas in a hash:
# * :for lambda- what to do
# * :until - until what is met. May be
# ** lambda
# ** symbol representing simple method call like element.visible?
# ** array representing complex method call like element.hasClass('activated') (e.g. [:hasClass, 'activated'])
# @return the result of the :for lambda
# todo: cover with specs
def wait lambdas = {}
  lambdas = {:for => nil, :until => lambda { |for_result| for_result.visible? } }.merge lambdas
  until_lambda = lambdas[:until]
  lambdas[:until] = lambda { |for_result| for_result.send until_lambda } if until_lambda.is_a? Symbol
  lambdas[:until] = lambda { |for_result| for_result.send until_lambda[0], *until_lambda[1..-1] } if until_lambda.is_a? Array

  require "timeout"
  Timeout.timeout(Capybara.default_wait_time) do
    result = lambdas[:for].call
    until lambdas[:until].call(result) do
      sleep 0.1
      result = lambdas[:for].call
    end
    result
  end
end

# more simple version of #wait, with more compact syntax:
# * using block as :for clause, not lambda
# * using symbol as :until clause, with additional args
# todo: cover with specs
def wait_for check = :visible?, *args, &block
  wait :for => block, :until => [check, *args]
end