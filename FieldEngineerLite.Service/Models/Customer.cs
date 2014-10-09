// ----------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// ----------------------------------------------------------------------------
// This file reused from: https://code.msdn.microsoft.com/Field-Engineer-501df99d

using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace FieldEngineerLite.Service.Models
{
    [Table("Customer")]
    public class Customer
    {
        public Customer()
        {
            this.Jobs = new HashSet<Job>();
        }

        [StringLength(50)]
        public string AdditionalContactNumber { get; set; }

        [StringLength(50)]
        public string County { get; set; }

        [StringLength(50)]
        public string FullName { get; set; }

        [StringLength(50)]
        public string HouseNumberOrName { get; set; }

        [StringLength(50)]
        public string Id { get; set; }

        public decimal? Latitude { get; set; }

        public decimal? Longitude { get; set; }

        [StringLength(50)]
        public string Postcode { get; set; }

        [StringLength(50)]
        public string PrimaryContactNumber { get; set; }

        [StringLength(50)]
        public string Street { get; set; }

        [StringLength(50)]
        public string Town { get; set; }

        public ICollection<Job> Jobs { get; set; }
    }
}
