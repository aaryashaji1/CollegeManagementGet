using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CollegeManagementGet.Models
{
    public class Student
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int Malayalam { get; set; }

        public int Hindi { get; set; }
        public int English { get; set; }
        public string Time { get; set; }
        public int Total { get; set; }
        public int Average { get; set; }
    }
}