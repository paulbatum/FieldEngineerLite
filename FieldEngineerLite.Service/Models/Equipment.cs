// ----------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// ----------------------------------------------------------------------------
// This file reused from: https://code.msdn.microsoft.com/Field-Engineer-501df99d

using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.WindowsAzure.Mobile.Service.Tables;
using Newtonsoft.Json;

namespace FieldEngineerLite.Service.Models
{
    [Table("Equipment")]
    public class Equipment : ITableData
    {
        public Equipment()
        {
            this.Jobs = new HashSet<Job>();
        }

        [StringLength(150)]
        public string Description { get; set; }

        [StringLength(50)]
        public string Id { get; set; }

        [StringLength(50)]
        public string EquipmentNumber { get; set; }

        [StringLength(50)]
        public string FullImage { get; set; }

        [StringLength(50)]
        public string Name { get; set; }

        [StringLength(50)]
        public string ThumbImage { get; set; }

        public DateTimeOffset? CreatedAt { get; set; }

        public bool Deleted { get; set; }

        [DatabaseGenerated(DatabaseGeneratedOption.Computed)]
        public DateTimeOffset? UpdatedAt { get; set; }

        [Timestamp]
        public byte[] Version { get; set; }

        public ICollection<Job> Jobs { get; set; }
    }
}
