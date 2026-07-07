# solution — completed GSP345 Terraform config

The final Terraform configuration submitted for the GSP345 challenge lab (scored 100/100),
preserved for the cohort/company record. See [`../COMPLETION.md`](../COMPLETION.md) for the
full run + gotchas.

```
solution/
├── main.tf                       # providers, GCS backend, 3 module calls, tf-firewall
├── variables.tf                  # region / zone / project_id (with lab defaults)
└── modules/
    ├── instances/instances.tf    # tf-instance-1 / -2 (e2-standard-2, on subnet-01/-02)
    │   ├── variables.tf
    │   └── outputs.tf
    └── storage/storage.tf        # tf-bucket-493120 (also the remote-state backend)
        ├── variables.tf
        └── outputs.tf
```

> [!NOTE]
> This is a **record, not runnable as-is** — the `backend "gcs"` bucket, project ID, and
> resource names belong to the now-deleted temporary lab. To reuse, swap those values and
> the network path in the firewall rule. The network module `v10.0.0` requires the **google
> provider `< 7.0.0`** (see COMPLETION.md).
