//
// System.ComponentModel.Design.CollectionEditor.cs
// 
// Author:
//   Andreas Nahr (ClassDevelopment@A-SoftTech.com)
// 
// (C) 2007 Andreas Nahr
// 

//
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files (the
// "Software"), to deal in the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to
// the following conditions:
// 
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//


using System;
using System.Reflection;
using System.Collections;
using System.ComponentModel;
using System.Drawing.Design;
using System.Windows.Forms;
using System.Windows.Forms.Design;

namespace System.ComponentModel.Design
{
	public class CollectionEditor : UITypeEditor
	{
		protected abstract class CollectionForm : Form
		{
			private CollectionEditor editor;
			private object editValue;

			public CollectionForm (CollectionEditor editor)
			{
				this.editor = editor;
			}

			protected Type CollectionItemType
			{
				get { return editor.CollectionItemType; }
			}

			protected Type CollectionType
			{
				get { return editor.CollectionType; }
			}

			protected ITypeDescriptorContext Context
			{
				get { return editor.Context; }
			}

			public object EditValue
			{
				get { return editValue; }
				set { 
					editValue = value;
					OnEditValueChanged ();
				}
			}

			protected object[] Items
			{
				get { return editor.GetItems (editValue); }
				set { editor.SetItems (editValue, value); }
			}

			protected Type[] NewItemTypes
			{
				get { return editor.NewItemTypes; }
			}

			protected bool CanRemoveInstance (object value)
			{
				return editor.CanRemoveInstance (value);
			}

			protected virtual bool CanSelectMultipleInstances ()
			{
				return editor.CanSelectMultipleInstances ();
			}

			protected object CreateInstance (Type itemType)
			{
				return editor.CreateInstance (itemType);
			}

			protected void DestroyInstance (object instance)
			{
				editor.DestroyInstance (instance);
			}

			protected virtual void DisplayError (Exception e)
			{
				MessageBox.Show (e.Message, "Cannot construct object", MessageBoxButtons.OK, MessageBoxIcon.Information);
			}

			protected override object GetService (Type serviceType)
			{
				return editor.GetService (serviceType);
			}

			protected abstract void OnEditValueChanged ();

			protected internal virtual DialogResult ShowEditorDialog (IWindowsFormsEditorService edSvc)
			{
				return edSvc.ShowDialog (this);
			}
		}

		private class ConcreteCollectionForm : CollectionForm
		{
			private CollectionEditor editor;

			private System.Windows.Forms.Label labelMember;
			private System.Windows.Forms.Label labelProperty;
			private System.Windows.Forms.ListBox itemsList;
			private System.Windows.Forms.PropertyGrid itemDisplay;
			private System.Windows.Forms.Button doClose;
			private System.Windows.Forms.Button moveUp;
			private System.Windows.Forms.Button moveDown;
			private System.Windows.Forms.Button doAdd;
			private System.Windows.Forms.Button doRemove;
			private System.Windows.lProperty.TabIoCancel;

			public ConcreteCollectionForm (CollectionEditor editor)
			: base (editor)
			{
				this.editor = editor;

				this.labelMember = new System.Windows.Forms.Label ();
				this.labelProperty = new System.Windows.Forms.Label ();
				this.itemsList = new System.Windows.Forms.ListBox ();
				this.itemDisplay = new System.Windows.Forms.PropertyGrid ();
				this.doClose = new System.Windows.Forms.Button ();
				this.moveUp = new System.Windows.Forms.Button ();
				this.moveDown = new System.Windows.Forms.Button ();
				this.doAdd = new System.Windows.Forms.Button ();
				this.doRemove = new System.Windows.Forms.Button ();
				this.doCancel = new System.Windows.Forms.Button ();
				this.SuspendLayout ();
				// 
				// labelMember
				// 
				this.labelMember.Location = new System.Drawi(System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
							| System.Windows.Forms.AnchorStyles.Left)
					Text = "Members:";
				// 
				// labelProperty
				// 
				this.labelProperty.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left)
							| System.Windows.Forms.AnchorStyles.Right)));
				this.labelProperty.Location = new System.Drawing.Point (172, 9);
				this.labelProperty.Size = new System.Drawing.Size (230, 13);
				this.labelProperty.TabIndex = 1;
				this.labelProperty.Text = "Properties:";
				// 
				// itemsList
				// 
				this.itemsList.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
							| System.Windows.Forms.AnchorStyles.Left)));
				this.itemsList.HorizontalScrollbar = true;
				this.itemsList.Location = new System.Drawing.Point (12, 25);
				this.itemsList.SelectionMode = System.Windows.Forms.SelectionMode.MultiExtended;
				this.itemsList.Size = new System.Drawing.Size (120, 225);
				this.itemsList.TabIndex = 0;
				this.itemsList.SelectedIndexChanged += new System.EventHandler (this.itemsList_SelectedIndexChanged);
				// 
				// itemDisplay
				// 
				this.itemDisplay.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
							| System.Windows.Forms.AnchorStyles.Left)
							| System.Windows.Forms.AnchorStyles.Right)));
				this.itemDisplay.HelpVisible = false;
				this.itemDisplay.Location = new System.Drawing.Point (175, 25);
				this.itemDisplay.Size = new System.Drawing.Size (227, 225);
				this.itemDisplay.TabIndex = 5;
				// 
				// doClose
				// 
				this.doClose.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
				this.doClose.Location = new System.Drawing.Point (224, 256);
				this.doClose.Size = new System.Drawing.Size (86, 26);
				this.doClose.TabIndex = 6;
				this.doClose.Text = "OK";
				this.doClose.UseVisualStyleBackColor = true;
				this.doClose.Click += new System.EventHandler (this.doClose_Click);
				// 
				// moveUp
				// 
				this.moveUp.Location = new System.Drawing.Point (138, 25);
				this.moveUp.Size = new System.Drawing.Size (31, 28);
				this.moveUp.TabIndex = 3;
				this.moveUp.Text = "Up";
				this.moveUp.UseVisualStyleBackColor = true;
				this.moveUp.Click += new System.EventHandler (this.moveUp_Click);
				// 
				// moveDown
				// 
				this.moveDown.Location = new System.Drawing.Point (138, 59);
				this.moveDown.Size = new System.Drawing.Size (31, 28);
				this.moveDown.TabIndex = 4;
				this.moveDown.Text = "Dn";
				this.moveDown.UseVisualStyleBackColor = true;
				this.moveDown.Click += new System.EventHandler (this.moveDown_Click);
				// 
				// doAdd
				// 
				this.doAdd.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
				this.doAdd.Location = new System.Drawing.Point (12, 257);
				this.doAdd.Size = new System.Drawing.Size (59, 25);
				this.doAdd.TabIndex = 1;
				this.doAdd.Text = "Add";
				this.doAdd.UseVisualStyleBackColor = true;
				this.doAdd.Click += new System.EventHandler (this.doAdd_Click);
				// 
				// doRemove
				// 
				this.doRemove.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
				this.doRemove.Location = new System.Drawing.Point (77, 257);
				this.doRemove.Size = new System.Drawing.Size (55, 25);
				this.doRemove.TabIndex = 2;
				this.doRemove.Text = "Remove";
				this.doRemove.UseVisualStyleBackColor = true;
				this.doRemove.Click += new System.EventHandler (this.doRemove_Click);
				// 
				// doCancel
				// 
				this.doCancel.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
				this.doCancel.DialogResult = System.Windows.Forms.DialogResult.Cancel;
				this.doCancel.Location = new System.Drawing.Point (316, 256);
				this.doCancel.Size = new System.Drawing.Size (86, 26);
				this.doCancel.TabIndex = 7;
				this.doCancel.Text = "Cancel";
				this.doCancel.UseVisualStyleBackColor = true;
				this.doCancel.Click += new System.EventHandler (this.doCancel_Click);
				// 
				// DesignerForm
				// 
				this.AcceptButton = this.doClose;
				this.AutoScaleDimensions = new System.Drawing.SizeF (6F, 13F);
				this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
				this.CancelButton = this.doCancel;
				this.ClientSize = new System.Drawing.Size (414, 292);
				this.ControlBox = false;
				this.Controls.Add (this.doCancel);
				this.Controls.Add (this.doRemove);
				this.Controls.Add (this.doAdd);
				this.Controls.Add (this.moveDown);
				this.Controls.Add (this.moveUp);
				this.Controls.Add (this.doClose);
				this.Controls.Add (this.itemDisplay);
				this.Controls.Add (this.itemsList);
				this.Controls.Add (this.labelProperty);
				this.Controls.Add (this.labelMember);
				this.HelpButton = true;
				this.MaximizeBox = false;
				this.MinimizeBox = false;
				this.MinimumSize = new System.Drawing.Size (400, 300);
				this.ShowInTaskbar = false;
				this.Text = " ";
				this.ResumeLayout (false);

				this.Text = editor.CollectionType.Name + " Collection Editor";
			}

			private void AddItems ()
			{
				this.itemsList.Items.AddRange(editor.GetItems (EditValue));
				if (itemsList.Items.Count > 0)
					itemsList.SelectedIndex = 0;
			}

			private void doClose_Click (object sender, EventArgs e)
			{
				object[] items = new object[itemsList.Items.Count];
				itemsList.Items.CopyTo (items, 0);
				EditValue = editor.SetItems (EditValue, items);
				this.Close ();
			}

			private void doCancel_Click (object sender, EventArgs e)
			{
				editor.CancelChanges ();
				this.Close ();
			}

			private void itemsList_SelectedIndexChanged (object sender, EventArgs e)
			{
				if (itemsList.SelectedIndex <= 0 || itemsList.SelectedItems.Count > 1)
					moveUp.Enabled = false;
				else
					moveUp.Enabled = true;
				if (itemsList.SelectedIndex > itemsList.Items.Count - 2 || itemsList.SelectedItems.Count > 1)
					moveDown.Enabled = false;
				else
					moveDown.Enabled = true;

				if (itemsList.SelectedItems.Count == 1)
					itemDisplay.SelectedObject = itemsList.SelectedItem;
				else
				{
					object[] items = new object [itemsList.SelectedItems.Count];
					itemsList.SelectedItems.CopyTo (items, 0);
					itemDisplay.SelectedObjects = items;
				}
				labelProperty.Text = editor.GetDisplayText(itemsList.SelectedItem);
			}

			private void moveUp_Click (object sender, EventArgs e)
			{
				if (itemsList.SelectedIndex <= 0)
					return;

				object selected = itemsList.SelectedItem;
				int index = itemsList.SelectedIndex;
				itemsList.Items.RemoveAt (index);
				itemsList.Items.Insert (index - 1, selected);
				itemsList.SelectedIndex = index - 1;
			}

			private void moveDown_Click (object sender, EventArgs e)
			{
				if (itemsList.SelectedIndex > itemsList.Items.Count - 2)
					return;

				object selected = itemsList.SelectedItem;
				int index = itemsList.SelectedIndex;
				itemsList.Items.RemoveAt (index);
				itemsList.Items.Insert (index + 1, selected);
				itemsList.SelectedIndex = index + 1;
			}

			private void doAdd_Click (object sender, EventArgs e)
			{
				//FIXME: Only supports a single type for adds
				object o;
				try
				{
					o = editor.CreateInstance (editor.NewItemTypes[0]);
				}
				catch (Exception ex)
				{
					DisplayError (ex);
					return;
				}
				itemsList.Items.Add(o);
			}

			private void doRemove_Click (object sender, EventArgs e)
			{
				if (itemsList.SelectedIndex != -1)
					itemsList.Items.RemoveAt (itemsList.SelectedIndex);
			}

			protected override void OnEditValueChanged ()
			{
				AddItems ();
			}
		}

		private Type type;
		private Type collectionItemType;
		private Type[] newItemTypes;
		private ITypeDescriptorContext context;
		private IServiceProvider provider;
		private IWindowsFormsEditorService editorService;

		public CollectionEditor (Type type)
		{
			this.type = type;
			this.collectionItemType = CreateCollectionItemType ();
			this.newItemTypes = CreateNewItemTypes ();
		}

		protected Type CollectionItemType
		{
			get { return collectionItemType; }
		}

		protected Type CollectionType
		{
			get { return type; }
		}

		protected ITypeDescriptorContext Context
		{
			get { return context; }
		}

		protected virtual string HelpTopic
		{
			get { return "CollectionEditor"; }
		}

		protected Type[] NewItemTypes
		{
			get { return newItemTypes; }
		}

		protected virtual void CancelChanges ()
		{
		}

		protected virtual bool CanRemoveInstance (object value)
		{
			return true;
		}

		protected virtual bool CanSelectMultipleInstances ()
		{
			return true;
		}

		protected virtual CollectionEditor.CollectionForm CreateCollectionForm ()
		{
			return new ConcreteCollectionForm (this);
		}

		protected virtual Type CreateCollectionItemType ()
		{
			PropertyInfo info = type.GetProperty ("Item");
			return info.PropertyType;
		}

		protected virtual object CreateInstance (Type itemType)
		{
			return TypeDescriptor.CreateInstance (provider, itemType, null, null);
		}

		protected virtual Type[] CreateNewItemTypes ()
		{
			return new Type[] { collectionItemType };
		}

		protected virtual void DestroyInstance (object instance)
		{
			//FIXME: I've got NO clue what this does and the documentation isn't helpfull either
		}

		public override object EditValue (ITypeDescriptorContext context, IServiceProvider provider, object value)
		{
			this.context = context;
			this.provider = provider;

			if (context != null && provider != null)
			{
				editorService = (IWindowsFormsEditorService)provider.GetService (typeof (IWindowsFormsEditorService));
				if (editorService != null)
				{
					CollectionForm editorForm = CreateCollectionForm ();
					editorForm.EditValue = value;

					editorForm.ShowEditorDialog (editorService);

					return editorForm.EditValue;
				}
			}
			return base.EditValue (context, provider, value);
		}

		protected virtual string GetDisplayText (object value)
		{
			if (value == null)
				return string.Empty;

			return value.ToString ();
		}

		public override UITypeEditorEditStyle GetEditStyle (ITypeDescriptorContext context)
		{
			return UITypeEditorEditStyle.Modal;
		}

		protected virtual object[] GetItems (object editValue)
		{
			if (editValue == null)
				return null;
			if (!(editValue is ICollection))
				return new object[0];
			ICollection coll = editValue as ICollection;
			object[] result = new object[coll.Count];
			coll.CopyTo (result, 0);
			return result;
		}

		protected virtual IList GetObjectsFromInstance (object instance)
		{
			ArrayList list = new ArrayList ();
			list.Add (instance);
			return list;
		}

		protected object GetService (Type serviceType)
		{
			return context.GetService (serviceType);
		}

		protected virtual object SetItems (object editValue, object[] value)
		{
			IList list;

			if (editValue == null)
				return null;

			if (!(editValue is IList))
				list = new ArrayList ();
			else
			{
				list = editValue as IList;
				list.Clear ();
			}

			foreach (object o in value)
				list.Add (o);

			return list;
		}

		protected virtual void ShowHelp ()
		{
		}
	}
}