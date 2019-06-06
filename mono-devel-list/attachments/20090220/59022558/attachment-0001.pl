//#################################################################
// Atribute ScrollBars
//#################################################################

		[DefaultValue (ScrollBars.Both)]
		[Localizable (true)]
        public ScrollBars ScrollBars
        {
            get { return scrollBars; }
            set
            {
                if (!Enum.IsDefined(typeof(ScrollBars), value))
                {
                    throw new InvalidEnumArgumentException("Invalid ScrollBars value.");
                }
                ////////////////////////////////////////////////////////////
                /// *** InvalidOperationException ***
                /// The System.Windows.Forms.DataGridView is unable to
                /// scroll due to a cell change that cannot be committed
                /// or canceled.
                ///////////////////////////////////////////////////////////
                scrollBars = value;
                if (value == ScrollBars.Vertical | value == ScrollBars.Both)
                {
                    verticalScrollBar.Visible = true;
                }
                else
                {
                    verticalScrollBar.Visible = false;
                }
                if (value == ScrollBars.Horizontal | value == ScrollBars.Both)
                {
                    horizontalScrollBar.Visible = true;
                }
                else
                {
                    horizontalScrollBar.Visible = false;
                }
            }
        }

//#################################################################
// Atribute ScrollBars
//#################################################################



//#################################################################
// Function OnPaint
//#################################################################

...

			if (AutoSize) {
				if (gridWidth > Size.Width || gridHeight > Size.Height) {
					Size = new Size(gridWidth, gridHeight);
				}
			}
			else {
                if (horizontalScrollBar.Visible && gridWidth > Size.Width)
                {
					horizontalVisible = true;
				}
                if (verticalScrollBar.Visible && gridHeight > Size.Height)
                {
					verticalVisible = true;
				}
                if (verticalScrollBar.Visible && horizontalScrollBar.Visible && (gridHeight + horizontalScrollBar.Height) > Size.Height)
                {
					verticalVisible = true;
				}
                if (horizontalScrollBar.Visible && verticalScrollBar.Visible && (gridWidth + verticalScrollBar.Width) > Size.Width)
                {
					horizontalVisible = true;
				}
				if (horizontalVisible) {
					horizontalScrollBar.Minimum = 0;
					horizontalScrollBar.Maximum = gridWidth;
					horizontalScrollBar.SmallChange = Columns[first_col_index].Width;
					int largeChange = ClientSize.Width - rowHeadersWidth;
					if (largeChange <= 0)
						largeChange = ClientSize.Width;
					horizontalScrollBar.LargeChange = largeChange;
				}
				if (verticalVisible) {
					verticalScrollBar.Minimum = 0;
					verticalScrollBar.Maximum = gridHeight;
					verticalScrollBar.SmallChange = first_row_height + 1;
					int largeChange = ClientSize.Height - columnHeadersHeight;
					if (largeChange <= 0)
						largeChange = ClientSize.Height;
					verticalScrollBar.LargeChange = largeChange;
				}
			}

...

//#################################################################
// Function OnPaint
//#################################################################
