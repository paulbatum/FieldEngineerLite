// ----------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// ----------------------------------------------------------------------------
// This file reused (with modifications) from: https://code.msdn.microsoft.com/Field-Engineer-501df99d

using System.Linq;
using System.Data.Entity;
using System.Data.Entity.ModelConfiguration.Conventions;
using Microsoft.WindowsAzure.Mobile.Service;
using Microsoft.WindowsAzure.Mobile.Service.Tables;

namespace FieldEngineerLite.Service.Models
{
    public partial class ExistingDbContext : DbContext
    {
        public ExistingDbContext()
            : base("name=MS_TableConnectionString")
        {            
        }

        public virtual DbSet<Customer> Customers { get; set; }
        public virtual DbSet<Equipment> Equipments { get; set; }
        public virtual DbSet<Job> Jobs { get; set; }
        public virtual DbSet<JobHistory> JobHistories { get; set; }       

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {            
            string schema = ServiceSettingsDictionary.GetSchemaName();
            if (!string.IsNullOrEmpty(schema))
            {
                modelBuilder.HasDefaultSchema(schema);
            }
            else
            {
                modelBuilder.HasDefaultSchema("dbo");
            }

            modelBuilder.Conventions.Add(
                new AttributeToColumnAnnotationConvention<TableColumnAttribute, string>(
                "ServiceTableColumn", (property, attributes) => attributes.Single().ColumnType.ToString()));

            modelBuilder.Entity<Customer>()
                .Property(e => e.AdditionalContactNumber)
                .IsUnicode(false);

            modelBuilder.Entity<Customer>()
                .Property(e => e.County)
                .IsUnicode(false);

            modelBuilder.Entity<Customer>()
                .Property(e => e.FullName)
                .IsUnicode(false);

            modelBuilder.Entity<Customer>()
                .Property(e => e.HouseNumberOrName)
                .IsUnicode(false);

            modelBuilder.Entity<Customer>()
                .Property(e => e.Id)
                .IsUnicode(false);

            modelBuilder.Entity<Customer>()
                .Property(e => e.Latitude)
                .HasPrecision(9, 6);

            modelBuilder.Entity<Customer>()
                .Property(e => e.Longitude)
                .HasPrecision(9, 6);

            modelBuilder.Entity<Customer>()
                .Property(e => e.Postcode)
                .IsUnicode(false);

            modelBuilder.Entity<Customer>()
                .Property(e => e.PrimaryContactNumber)
                .IsUnicode(false);

            modelBuilder.Entity<Customer>()
                .Property(e => e.Street)
                .IsUnicode(false);

            modelBuilder.Entity<Customer>()
                .Property(e => e.Town)
                .IsUnicode(false);

            modelBuilder.Entity<Equipment>()
                .Property(e => e.Description)
                .IsUnicode(false);

            modelBuilder.Entity<Equipment>()
                .Property(e => e.Id)
                .IsUnicode(false);

            modelBuilder.Entity<Equipment>()
                .Property(e => e.EquipmentNumber)
                .IsUnicode(false);

            modelBuilder.Entity<Equipment>()
                .Property(e => e.FullImage)
                .IsUnicode(false);

            modelBuilder.Entity<Equipment>()
                .Property(e => e.Name)
                .IsUnicode(false);

            modelBuilder.Entity<Equipment>()
                .Property(e => e.ThumbImage)
                .IsUnicode(false);

            modelBuilder.Entity<Equipment>()
                .HasMany(e => e.Jobs)
                .WithMany(e => e.Equipments)
                .Map(m => m.ToTable("EquipmentIds").MapLeftKey("EquipmentId").MapRightKey("JobId"));

            modelBuilder.Entity<Job>()
                .Property(e => e.CustomerId)
                .IsUnicode(false);

            modelBuilder.Entity<Job>()
                .Property(e => e.EtaTime)
                .IsUnicode(false);

            modelBuilder.Entity<Job>()
                .Property(e => e.Id)
                .IsUnicode(false);

            modelBuilder.Entity<Job>()
                .Property(e => e.JobNumber)
                .IsUnicode(false);

            modelBuilder.Entity<Job>()
                .Property(e => e.Status)
                .IsUnicode(false);

            modelBuilder.Entity<Job>()
                .Property(e => e.Title)
                .IsUnicode(false);

            modelBuilder.Entity<JobHistory>()
                .Property(e => e.ActionBy)
                .IsUnicode(false);

            modelBuilder.Entity<JobHistory>()
                .Property(e => e.Comments)
                .IsUnicode(false);

            modelBuilder.Entity<JobHistory>()
                .Property(e => e.JobId)
                .IsUnicode(false);

            modelBuilder.Entity<JobHistory>()
                .Property(e => e.Id)
                .IsUnicode(false);
        }
    }
}
