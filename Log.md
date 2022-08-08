
# Implemented
~~address_stmt~~  
~~remote_label_stmt~~  
~~filler_stmt~~  
~~const_stmt~~  
~~data_stmt~~  
nop_brk_stmt  
flag_set_stmt  
stack_stmt  
goto_stmt  
bit_shift_stmt  
logic_stmt  
compare_stmt  
bittest_stmt  
gosub_stmt  
return_stmt  
assign_stmt  
arithmetic_stmt  

# To do
* Add keywords `bit7` & `bit6`?. See [ref](##2022-8-5)

## 2022-8-5
Should add the keywords `bit7` & `bit6`.
In assembly you would check for these bits using `BVC`, `BVS`, `BPL` & `BMI`, most likely after `BIT` & `CMP`.
To explicitly state that you aren't really checking for sign or overflow as the mnemonics suggest, you would use `if bit7 = 1`, etc.
That way you explicitly state that you are checking for arbitrary bits.
Of course the rest of the bits (0..5) don't have a corresponding CPU flag, so they must be tested with a more classical approach.
* Edit: Hold on, haven't yet decided on how to implement BIT & CMP.

## 2022-4-6
const and data are implemented, although some value types are not implemented yet.  
Will implement all value types as they come up in tests or use cases.  
