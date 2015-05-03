StarbucksElixir
===============

#start all!
StarbucksElixir.start

#generate 5 customer!
{:ok, masato1} = Customer.start("masato1")
{:ok, masato2} = Customer.start("masato2")
{:ok, masato3} = Customer.start("masato3")
{:ok, masato4} = Customer.start("masato4")
{:ok, masato5} = Customer.start("masato5")

#order coffee!
Customer.want_coffee(masato1)

** TODO: Add description **
