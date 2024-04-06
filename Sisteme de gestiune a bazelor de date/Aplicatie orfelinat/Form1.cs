using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;

namespace Aplicatie_Orfelinat
{
    public partial class Form1 : Form
    {
        SqlConnection connectionString = new SqlConnection(@"Data Source = DESKTOP-K397NVJ\SQLEXPRESS; Database = Orfelinat; Integrated Security = true");
        SqlDataAdapter dataAdapterCopii = new SqlDataAdapter();
        DataSet dataSetCopii = new DataSet();
        DataSet dataSetActivitati = new DataSet();

        public Form1()
        {
            InitializeComponent();
        }

        private void button_display_Click(object sender, EventArgs e)
        {
            dataAdapterCopii.SelectCommand = new SqlCommand("SELECT * FROM Copii", connectionString);
            dataSetCopii.Clear();
            dataAdapterCopii.Fill(dataSetCopii);
            dataGridView_Copii.DataSource = dataSetCopii.Tables[0];

            textBox_descriere.Text = "";
            textBox_indrumator_activitate.Text = "";
            textBox_locatie.Text = "";
            numericUpDown_numar_maxim_participanti.Value = 1;
            textBox_lucruri_necesare.Text = "";
        }

        private void showActivitati()
        {
            int FKid = int.Parse(dataGridView_Copii.SelectedRows[0].Cells[0].Value.ToString());
            try
            {
                dataAdapterCopii.SelectCommand = new SqlCommand("SELECT * FROM Activitati WHERE id_dosar_copil = @id_dosar_copil", connectionString);
                dataAdapterCopii.SelectCommand.Parameters.Add("@id_dosar_copil", SqlDbType.Int).Value = FKid;
                dataSetActivitati.Clear();
                dataAdapterCopii.Fill(dataSetActivitati);
                dataGridView_Activitati.DataSource = dataSetActivitati.Tables[0];

                textBox_descriere.Text = "";
                textBox_indrumator_activitate.Text = "";
                textBox_locatie.Text = "";
                numericUpDown_numar_maxim_participanti.Value = 1;
                textBox_lucruri_necesare.Text = "";
            }
            catch (Exception exception)
            {
                MessageBox.Show(exception.Message);
                connectionString.Close();
            }
        }

        private void dataGridView_Copii_RowHeaderMouseClick(object sender, DataGridViewCellMouseEventArgs e)
        {
            showActivitati();
        }

        private void button_add_Click(object sender, EventArgs e)
        {
            try
            {
                int FKid = int.Parse(dataGridView_Copii.SelectedRows[0].Cells[0].Value.ToString());
                dataAdapterCopii.InsertCommand = new SqlCommand("INSERT INTO Activitati(id_dosar_copil, descriere, indrumator_activitate, locatie, numar_maxim_participanti, lucruri_necesare) VALUES (@id_dosar_copil, @descriere, @indrumator_activitate, @locatie, @numar_maxim_participanti, @lucruri_necesare)", connectionString);
                dataAdapterCopii.InsertCommand.Parameters.Add("@descriere", SqlDbType.VarChar).Value = textBox_descriere.Text.Trim();
                dataAdapterCopii.InsertCommand.Parameters.Add("@indrumator_activitate", SqlDbType.VarChar).Value = textBox_indrumator_activitate.Text.Trim();
                dataAdapterCopii.InsertCommand.Parameters.Add("@locatie", SqlDbType.VarChar).Value = textBox_locatie.Text.Trim();
                dataAdapterCopii.InsertCommand.Parameters.Add("@numar_maxim_participanti", SqlDbType.Int).Value = numericUpDown_numar_maxim_participanti.Text.Trim();
                dataAdapterCopii.InsertCommand.Parameters.Add("@lucruri_necesare", SqlDbType.VarChar).Value = textBox_lucruri_necesare.Text.Trim();
                dataAdapterCopii.InsertCommand.Parameters.Add("@id_dosar_copil", SqlDbType.Int).Value = FKid;

                connectionString.Open();
                dataAdapterCopii.InsertCommand.ExecuteNonQuery();
                MessageBox.Show("Inserted succesfull to the Database");
                connectionString.Close();
                showActivitati();
            }
            catch (Exception exception)
            {
                MessageBox.Show(exception.Message);
                connectionString.Close();
            }
        }

        private void dataGridView_Activitati_RowHeaderMouseClick(object sender, DataGridViewCellMouseEventArgs e)
        {
            textBox_descriere.Text = dataGridView_Activitati.SelectedRows[0].Cells[2].Value.ToString();
            textBox_indrumator_activitate.Text = dataGridView_Activitati.SelectedRows[0].Cells[3].Value.ToString();
            textBox_locatie.Text = dataGridView_Activitati.SelectedRows[0].Cells[4].Value.ToString();
            numericUpDown_numar_maxim_participanti.Value = int.Parse(dataGridView_Activitati.SelectedRows[0].Cells[5].Value.ToString());
            textBox_lucruri_necesare.Text = dataGridView_Activitati.SelectedRows[0].Cells[6].Value.ToString();
        }

        private void button_update_Click(object sender, EventArgs e)
        {
            try
            {
                dataAdapterCopii.UpdateCommand = new SqlCommand("UPDATE Activitati SET descriere = @descriere, indrumator_activitate = @indrumator_activitate, locatie = @locatie, numar_maxim_participanti = @numar_maxim_participanti, lucruri_necesare = @lucruri_necesare WHERE cod_activitate = @cod_activitate", connectionString);
                dataAdapterCopii.UpdateCommand.Parameters.Add("@cod_activitate", SqlDbType.Int).Value = int.Parse(dataGridView_Activitati.SelectedRows[0].Cells[0].Value.ToString());

                dataAdapterCopii.UpdateCommand.Parameters.Add("@descriere", SqlDbType.VarChar).Value = textBox_descriere.Text.Trim();
                dataAdapterCopii.UpdateCommand.Parameters.Add("@indrumator_activitate", SqlDbType.VarChar).Value = textBox_indrumator_activitate.Text.Trim();
                dataAdapterCopii.UpdateCommand.Parameters.Add("@locatie", SqlDbType.VarChar).Value = textBox_locatie.Text.Trim();
                dataAdapterCopii.UpdateCommand.Parameters.Add("@numar_maxim_participanti", SqlDbType.Int).Value = numericUpDown_numar_maxim_participanti.Value;
                dataAdapterCopii.UpdateCommand.Parameters.Add("@lucruri_necesare", SqlDbType.VarChar).Value = textBox_lucruri_necesare.Text.Trim();
                
                connectionString.Open();
                dataAdapterCopii.UpdateCommand.ExecuteNonQuery();
                MessageBox.Show("Updated succesfull to the Database");
                connectionString.Close();
                showActivitati();
            }
            catch (Exception exception)
            {
                MessageBox.Show(exception.Message);
                connectionString.Close();
            }
        }

        private void button_delete_Click(object sender, EventArgs e)
        {
            try
            {
                dataAdapterCopii.DeleteCommand = new SqlCommand("DELETE FROM Activitati WHERE cod_activitate = @cod_activitate", connectionString);
                dataAdapterCopii.DeleteCommand.Parameters.Add("@cod_activitate", SqlDbType.Int).Value = int.Parse(dataGridView_Activitati.SelectedRows[0].Cells[0].Value.ToString());

                connectionString.Open();
                dataAdapterCopii.DeleteCommand.ExecuteNonQuery();
                MessageBox.Show("Deleted succesfull from the Database");
                connectionString.Close();

                showActivitati();
            }
            catch (Exception exception)
            {
                MessageBox.Show(exception.Message);
                connectionString.Close();
            }
        }
    }
}
