// ----------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// ----------------------------------------------------------------------------
// This file reused from: https://code.msdn.microsoft.com/Field-Engineer-501df99d

using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace FieldEngineerLite.Service.Models
{
    [Table("JobHistory")]
    public class JobHistory
    {
        [StringLength(50)]
        public string ActionBy { get; set; }

        [StringLength(50)]
        public string Comments { get; set; }

        [StringLength(50)]
        public string JobId { get; set; }

        public DateTimeOffset TimeStamp { get; set; }

        [StringLength(50)]
        public string Id { get; set; }

        public virtual Job Job { get; set; }
    }
}
