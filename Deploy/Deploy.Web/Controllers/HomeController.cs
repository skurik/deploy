using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Dapper;

namespace Deploy.Web.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            var connectionStringName = "mews-develop-sql-weu/mews-develop-db";
            var connectionString = ConfigurationManager.ConnectionStrings[connectionStringName].ConnectionString;
            ViewBag.ConnectionString = connectionString;
            ViewBag.Indexes = new List<string>();

            try
            {
                var connection = new SqlConnection(connectionString);
                connection.Open();

                using (var tx = connection.BeginTransaction())
                {
                    var sql = @"
                        SELECT 
                            i.[name] as [Name]
                        FROM
                            sys.indexes i
                        JOIN
                            sys.index_columns ic ON
                            i.[index_id] = ic.[index_id] AND
                            i.[object_id] = ic.[object_id]
                        JOIN
                            sys.columns c ON 
                            c.[column_id] = ic.[column_id] AND
                            ic.[object_id] = c.[object_id]";

                    var indexes = connection.Query<string>(sql).ToList();
                    ViewBag.Indexes = indexes;

                    tx.Commit();
                }
            }
            catch (Exception e)
            {
                ViewBag.Error = e.Message;
                ViewBag.StackTrace = e.StackTrace;
            }

            return View();
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }
    }
}