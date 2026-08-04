# 08 — Host anomaly scan

Scans known Aura host residuals (hash capacity, wall-clock resolution, fiber:spawn).

**PASS** means: scan finished and pure-Aura core rebind denseness still holds.  
Anomalies print as `HOST_ANOMALY id=…` lines for upstream filing.

```bash
./scripts/run-aura.sh examples/08-host-anomaly-scan/main.aura
```

See `notes/host-residuals.md` and Aura issues filed from Hephaestus denseness work.
