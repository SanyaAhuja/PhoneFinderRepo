using PhoneFinder.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.UI.WebControls;

namespace PhoneFinder.DAL
{
    public class DBContext
    {
        public static void GetData(out List<Brand> brandList, out List<OS> osList)
        {
            osList = null;
            brandList = null;

            SqlConnection conn = new SqlConnection();
            conn.ConnectionString =
             "Data Source=EXIPC0019\\SQLEXPRESS;" +
             "Initial Catalog=PhoneFinderDB;" +
             "Integrated Security=SSPI;";
            //SqlConnection con = new SqlConnection(strConnString);
            try
            {
                conn.Open();
                SqlDataAdapter da = new SqlDataAdapter("GetMenu", conn);
                da.SelectCommand.CommandType = CommandType.StoredProcedure;
                DataSet ds = new DataSet();

                da.Fill(ds);

                brandList = ds.Tables[0].AsEnumerable().Select(item => new Brand
                {
                    Id = Convert.ToInt32(item["Id"]),
                    Name = item["Name"].ToString()
                }).ToList();

                osList = ds.Tables[1].AsEnumerable().Select(item => new OS
                {
                    OSId = Convert.ToInt32(item["OSId"]),
                    Name = item["Name"].ToString()
                }).ToList();

                //conn.Close();

            }
            catch (Exception ex)
            {
                var err = ex.Message;
            }
        }
        public static void GetPhoneList(out List<Phone> phoneList)
        {
            phoneList = null;
            SqlConnection conn = new SqlConnection();
            conn.ConnectionString =
             "Data Source=EXIPC0019\\SQLEXPRESS;" +
             "Initial Catalog=PhoneFinderDB;" +
             "Integrated Security=SSPI;";
            try
            {
                conn.Open();
                SqlDataAdapter da1 = new SqlDataAdapter("GetId", conn);
                da1.SelectCommand.CommandType = CommandType.StoredProcedure;
                DataSet ds1 = new DataSet();
                var host = HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Authority);

                da1.Fill(ds1);

                phoneList = ds1.Tables[0].AsEnumerable().Select(item => new Phone

                {
                    Id = Convert.ToInt32(item["Id"]),
                    Name = item["Name"].ToString(),
                    ImagePath = host + "\\" + item["ImagePath"].ToString(),
                    BrandId = Convert.ToInt32(item["BrandId"]),
                    OSId = Convert.ToInt32(item["OSId"])


                }).ToList();

                conn.Close();
            }
            catch (Exception ex)
            {
                var err = ex.Message;
            }
        }

        public static void GetDetailList(out Phone phonedetail,int id)
        {
            phonedetail = null;
            SqlConnection conn = new SqlConnection();
            conn.ConnectionString =
             "Data Source=EXIPC0019\\SQLEXPRESS;" +
             "Initial Catalog=PhoneFinderDB;" +
             "Integrated Security=SSPI;";
            try
            {
                conn.Open();
                SqlDataAdapter da2 = new SqlDataAdapter("GetPhone", conn);
                da2.SelectCommand.CommandType = CommandType.StoredProcedure;
                da2.SelectCommand.Parameters.AddWithValue("@Id", id);
                DataSet ds2 = new DataSet();
                var host = HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Authority);

                da2.Fill(ds2);

                phonedetail = ds2.Tables[0].AsEnumerable().Select(item => new Phone

                {

                    Name = item["Name"].ToString(),
                    ImagePath = host + "\\" + item["ImagePath"].ToString(),
                    Price = Convert.ToInt32(item["Price"]),
                    Dimension = item["Dimension"].ToString(),
                    ReleasedDate = Convert.ToDateTime(item["ReleasedDate"])


                }).ToList()[0];

                conn.Close();
            }
            catch (Exception ex)
            {
                var err = ex.Message;
            }



        }

    }
}