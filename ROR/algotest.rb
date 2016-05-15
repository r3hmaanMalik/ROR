
require 'apriori/algorithm'
algorithm = Apriori::Algorithm.new(0.15, 0.7)
#algorithm = Apriori::Algorithm.new(0.15, 0.8)
filename = ARGV.first
target = open(filename, 'w')

target2 = open('rio.txt', 'w')


transactions = [  %w{beer doritos xx},
                    %w{apple cheese bb}, 
                    %w{beer doritos xx}, 
                    %w{apple cheese bb}, 
                    %w{apple cheese bb}, 
                    %w{apple doritos xx bb} ]




puts(transactions)
result = algorithm.analyze(transactions)

target.write(result.frequent_item_sets)
target2.write(result.association_rules)
