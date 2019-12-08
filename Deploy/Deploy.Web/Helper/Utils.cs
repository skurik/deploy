using System;
using System.IO;
using System.Reflection;

namespace Deploy.Web.Helper
{
    public static class Utils
    {
        private static DateTime? buildDate;

        public static DateTime BuildDate
        {   
            get
            {
                if (!buildDate.HasValue)
                    buildDate = RetrieveLinkerTimestamp(Assembly.GetExecutingAssembly().Location);

                return buildDate.Value;
            }
        }

        public static DateTime RetrieveLinkerTimestamp(string filePath)
        {
            const int peHeaderOffset = 60;
            const int linkerTimestampOffset = 8;

            var b = new byte[2048];
            Stream s = null;
            try
            {
                s = new FileStream(filePath, FileMode.Open, FileAccess.Read);
                s.Read(b, 0, 2048);

            }
            finally
            {
                s?.Close();
            }

            var i = BitConverter.ToInt32(b, peHeaderOffset);
            var secondsSince1970 = BitConverter.ToInt32(b, i + linkerTimestampOffset);
            var dt = new DateTime(1970, 1, 1, 0, 0, 0);
            dt = dt.AddSeconds(secondsSince1970);
            dt = dt.AddHours(TimeZone.CurrentTimeZone.GetUtcOffset(dt).Hours);
            return DateTime.SpecifyKind(dt, DateTimeKind.Local);
        }
    }
}