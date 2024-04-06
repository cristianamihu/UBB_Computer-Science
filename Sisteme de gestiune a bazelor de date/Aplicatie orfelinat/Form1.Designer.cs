namespace Aplicatie_Orfelinat
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.button_display = new System.Windows.Forms.Button();
            this.dataGridView_Activitati = new System.Windows.Forms.DataGridView();
            this.dataGridView_Copii = new System.Windows.Forms.DataGridView();
            this.button_add = new System.Windows.Forms.Button();
            this.button_delete = new System.Windows.Forms.Button();
            this.button_update = new System.Windows.Forms.Button();
            this.label_indrumator_activitate = new System.Windows.Forms.Label();
            this.label_locatie = new System.Windows.Forms.Label();
            this.label_numar_maxim_participanti = new System.Windows.Forms.Label();
            this.label_lucruri_necesare = new System.Windows.Forms.Label();
            this.numericUpDown_numar_maxim_participanti = new System.Windows.Forms.NumericUpDown();
            this.textBox_descriere = new System.Windows.Forms.TextBox();
            this.textBox_indrumator_activitate = new System.Windows.Forms.TextBox();
            this.textBox_locatie = new System.Windows.Forms.TextBox();
            this.textBox_lucruri_necesare = new System.Windows.Forms.TextBox();
            this.label_descriere = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView_Activitati)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView_Copii)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.numericUpDown_numar_maxim_participanti)).BeginInit();
            this.SuspendLayout();
            // 
            // button_display
            // 
            this.button_display.Location = new System.Drawing.Point(31, 376);
            this.button_display.Name = "button_display";
            this.button_display.Size = new System.Drawing.Size(80, 31);
            this.button_display.TabIndex = 0;
            this.button_display.Text = "Display";
            this.button_display.UseVisualStyleBackColor = true;
            this.button_display.Click += new System.EventHandler(this.button_display_Click);
            // 
            // dataGridView_Activitati
            // 
            this.dataGridView_Activitati.BackgroundColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(192)))), ((int)(((byte)(192)))));
            this.dataGridView_Activitati.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView_Activitati.Location = new System.Drawing.Point(770, 25);
            this.dataGridView_Activitati.Name = "dataGridView_Activitati";
            this.dataGridView_Activitati.RowHeadersWidth = 51;
            this.dataGridView_Activitati.RowTemplate.Height = 24;
            this.dataGridView_Activitati.Size = new System.Drawing.Size(669, 211);
            this.dataGridView_Activitati.TabIndex = 1;
            this.dataGridView_Activitati.RowHeaderMouseClick += new System.Windows.Forms.DataGridViewCellMouseEventHandler(this.dataGridView_Activitati_RowHeaderMouseClick);
            // 
            // dataGridView_Copii
            // 
            this.dataGridView_Copii.BackgroundColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(192)))), ((int)(((byte)(192)))));
            this.dataGridView_Copii.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView_Copii.Location = new System.Drawing.Point(31, 25);
            this.dataGridView_Copii.Name = "dataGridView_Copii";
            this.dataGridView_Copii.RowHeadersWidth = 51;
            this.dataGridView_Copii.RowTemplate.Height = 24;
            this.dataGridView_Copii.Size = new System.Drawing.Size(656, 330);
            this.dataGridView_Copii.TabIndex = 2;
            this.dataGridView_Copii.RowHeaderMouseClick += new System.Windows.Forms.DataGridViewCellMouseEventHandler(this.dataGridView_Copii_RowHeaderMouseClick);
            // 
            // button_add
            // 
            this.button_add.Location = new System.Drawing.Point(1284, 289);
            this.button_add.Name = "button_add";
            this.button_add.Size = new System.Drawing.Size(80, 33);
            this.button_add.TabIndex = 3;
            this.button_add.Text = "Add";
            this.button_add.UseVisualStyleBackColor = true;
            this.button_add.Click += new System.EventHandler(this.button_add_Click);
            // 
            // button_delete
            // 
            this.button_delete.BackColor = System.Drawing.Color.Snow;
            this.button_delete.Location = new System.Drawing.Point(1284, 423);
            this.button_delete.Name = "button_delete";
            this.button_delete.Size = new System.Drawing.Size(80, 33);
            this.button_delete.TabIndex = 4;
            this.button_delete.Text = "Delete";
            this.button_delete.UseVisualStyleBackColor = false;
            this.button_delete.Click += new System.EventHandler(this.button_delete_Click);
            // 
            // button_update
            // 
            this.button_update.Location = new System.Drawing.Point(1285, 357);
            this.button_update.Name = "button_update";
            this.button_update.Size = new System.Drawing.Size(79, 33);
            this.button_update.TabIndex = 5;
            this.button_update.Text = "Update";
            this.button_update.UseVisualStyleBackColor = true;
            this.button_update.Click += new System.EventHandler(this.button_update_Click);
            // 
            // label_indrumator_activitate
            // 
            this.label_indrumator_activitate.AutoSize = true;
            this.label_indrumator_activitate.Location = new System.Drawing.Point(862, 325);
            this.label_indrumator_activitate.Name = "label_indrumator_activitate";
            this.label_indrumator_activitate.Size = new System.Drawing.Size(130, 16);
            this.label_indrumator_activitate.TabIndex = 8;
            this.label_indrumator_activitate.Text = "indrumator_activitate";
            // 
            // label_locatie
            // 
            this.label_locatie.AutoSize = true;
            this.label_locatie.Location = new System.Drawing.Point(862, 359);
            this.label_locatie.Name = "label_locatie";
            this.label_locatie.Size = new System.Drawing.Size(47, 16);
            this.label_locatie.TabIndex = 9;
            this.label_locatie.Text = "locatie";
            // 
            // label_numar_maxim_participanti
            // 
            this.label_numar_maxim_participanti.AutoSize = true;
            this.label_numar_maxim_participanti.Location = new System.Drawing.Point(862, 397);
            this.label_numar_maxim_participanti.Name = "label_numar_maxim_participanti";
            this.label_numar_maxim_participanti.Size = new System.Drawing.Size(162, 16);
            this.label_numar_maxim_participanti.TabIndex = 10;
            this.label_numar_maxim_participanti.Text = "numar_maxim_participanti";
            // 
            // label_lucruri_necesare
            // 
            this.label_lucruri_necesare.AutoSize = true;
            this.label_lucruri_necesare.Location = new System.Drawing.Point(862, 434);
            this.label_lucruri_necesare.Name = "label_lucruri_necesare";
            this.label_lucruri_necesare.Size = new System.Drawing.Size(106, 16);
            this.label_lucruri_necesare.TabIndex = 11;
            this.label_lucruri_necesare.Text = "lucruri_necesare";
            // 
            // numericUpDown_numar_maxim_participanti
            // 
            this.numericUpDown_numar_maxim_participanti.Location = new System.Drawing.Point(1045, 391);
            this.numericUpDown_numar_maxim_participanti.Minimum = new decimal(new int[] {
            1,
            0,
            0,
            0});
            this.numericUpDown_numar_maxim_participanti.Name = "numericUpDown_numar_maxim_participanti";
            this.numericUpDown_numar_maxim_participanti.Size = new System.Drawing.Size(120, 22);
            this.numericUpDown_numar_maxim_participanti.TabIndex = 13;
            this.numericUpDown_numar_maxim_participanti.Value = new decimal(new int[] {
            1,
            0,
            0,
            0});
            // 
            // textBox_descriere
            // 
            this.textBox_descriere.Location = new System.Drawing.Point(1045, 285);
            this.textBox_descriere.Name = "textBox_descriere";
            this.textBox_descriere.Size = new System.Drawing.Size(120, 22);
            this.textBox_descriere.TabIndex = 14;
            // 
            // textBox_indrumator_activitate
            // 
            this.textBox_indrumator_activitate.Location = new System.Drawing.Point(1045, 319);
            this.textBox_indrumator_activitate.Name = "textBox_indrumator_activitate";
            this.textBox_indrumator_activitate.Size = new System.Drawing.Size(120, 22);
            this.textBox_indrumator_activitate.TabIndex = 15;
            // 
            // textBox_locatie
            // 
            this.textBox_locatie.Location = new System.Drawing.Point(1045, 353);
            this.textBox_locatie.Name = "textBox_locatie";
            this.textBox_locatie.Size = new System.Drawing.Size(120, 22);
            this.textBox_locatie.TabIndex = 17;
            // 
            // textBox_lucruri_necesare
            // 
            this.textBox_lucruri_necesare.Location = new System.Drawing.Point(1045, 434);
            this.textBox_lucruri_necesare.Name = "textBox_lucruri_necesare";
            this.textBox_lucruri_necesare.Size = new System.Drawing.Size(120, 22);
            this.textBox_lucruri_necesare.TabIndex = 19;
            // 
            // label_descriere
            // 
            this.label_descriere.AutoSize = true;
            this.label_descriere.Location = new System.Drawing.Point(865, 290);
            this.label_descriere.Name = "label_descriere";
            this.label_descriere.Size = new System.Drawing.Size(64, 16);
            this.label_descriere.TabIndex = 20;
            this.label_descriere.Text = "descriere";
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.MistyRose;
            this.ClientSize = new System.Drawing.Size(1466, 571);
            this.Controls.Add(this.label_descriere);
            this.Controls.Add(this.textBox_lucruri_necesare);
            this.Controls.Add(this.textBox_locatie);
            this.Controls.Add(this.textBox_indrumator_activitate);
            this.Controls.Add(this.textBox_descriere);
            this.Controls.Add(this.numericUpDown_numar_maxim_participanti);
            this.Controls.Add(this.label_lucruri_necesare);
            this.Controls.Add(this.label_numar_maxim_participanti);
            this.Controls.Add(this.label_locatie);
            this.Controls.Add(this.label_indrumator_activitate);
            this.Controls.Add(this.button_update);
            this.Controls.Add(this.button_delete);
            this.Controls.Add(this.button_add);
            this.Controls.Add(this.dataGridView_Copii);
            this.Controls.Add(this.dataGridView_Activitati);
            this.Controls.Add(this.button_display);
            this.Name = "Form1";
            this.Text = "OrfelinatApp";
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView_Activitati)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView_Copii)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.numericUpDown_numar_maxim_participanti)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button button_display;
        private System.Windows.Forms.DataGridView dataGridView_Activitati;
        private System.Windows.Forms.DataGridView dataGridView_Copii;
        private System.Windows.Forms.Button button_add;
        private System.Windows.Forms.Button button_delete;
        private System.Windows.Forms.Button button_update;
        private System.Windows.Forms.Label label_indrumator_activitate;
        private System.Windows.Forms.Label label_locatie;
        private System.Windows.Forms.Label label_numar_maxim_participanti;
        private System.Windows.Forms.Label label_lucruri_necesare;
        private System.Windows.Forms.NumericUpDown numericUpDown_numar_maxim_participanti;
        private System.Windows.Forms.TextBox textBox_descriere;
        private System.Windows.Forms.TextBox textBox_indrumator_activitate;
        private System.Windows.Forms.TextBox textBox_locatie;
        private System.Windows.Forms.TextBox textBox_lucruri_necesare;
        private System.Windows.Forms.Label label_descriere;
    }
}

