StarbucksElixir
===============
inspired by [Your Coffee Shop Doesn’t Use Two-Phase Commit](http://www.eaipatterns.com/docs/IEEE_Software_Design_2PC.pdf).<br>
<br>
the Starbucks shop demo base on Elixir<br>
<br>
#geting start
```elixir
cd starbucks_elixir
iex -S mix
```
#start all
```elixir
StarbucksElixir.start
```

#generate 5 customer!
```elixir
{:ok, masato1} = Customer.start("masato1")
{:ok, masato2} = Customer.start("masato2")
{:ok, masato3} = Customer.start("masato3")
{:ok, masato4} = Customer.start("masato4")
{:ok, masato5} = Customer.start("masato5")
```

#order coffee!
```elixir
Customer.want_coffee(masato1)
```

#check order
```elisir
Queue.status
```

** TODO: Add description **
