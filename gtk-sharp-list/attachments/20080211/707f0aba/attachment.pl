the SelectLine method provided won't select anything if the line
parameter is the last line of the buffer. to handle that case you'd want
something like this:

private void SelectLine (TextView view, int line) {
	TextBuffer buffer = view.Buffer;

	TextIter start, end;
	start = end = buffer.GetIterAtLine (line);
	end.LineOffset = start.CharsInLine;

	buffer.SelectRange (start, end);
}

--anthony

On Mon, 2008-02-11 at 11:10 -0500, Chris Howie wrote:
> On Feb 8, 2008 9:04 AM, Darwin Reynoso <monouser@gmail.com> wrote:
> > Hi,
> > how do i select a line in a textview.
> 
> private void SelectLine(TextView view, int line) {
>         TextBuffer buffer = view.Buffer;
> 
>         TextIter start = buffer.GetIterAtLine(line);
>         TextIter end = buffer.GetIterAtLine(line + 1);
> 
>         buffer.SelectRange(start, end);
> }
> 
> P.S. Documentation is a wonderful thing.
> 

