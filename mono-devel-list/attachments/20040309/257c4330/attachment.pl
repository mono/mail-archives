> Plus, I have a slightly different take on
> fixing the bug, although I think Ivan's fix is just as good.

Nope, Ivan's fix sucked.
It breaks other things (see, told you not to trust my fix).

EmitDynamicInitializers also checks if num_automatic_initializers <= max_automatic_initializers, so my little fix said when to do static but I didn't adjust when EmitDynamicInitializers will do dymanic... leaving a gap. :(

Well, it was my first look at the compiler... and didn't that go well?

Anyway, your fix looks alot more elegant (and it doesn't appear to suffer the issue mine had), so I'm going for yours.

--- Ivan Hamilton <ivan@chimerical.com.au> wrote:
A small change to the if expression in expression.cs appears to fix the problem. 

!!Note!! I haven't regression tested this change. I don't think it's appropriate that I do (being a total n00b). But at least there's some more information here, so that someone who knows what they're doing can implement a fix.

