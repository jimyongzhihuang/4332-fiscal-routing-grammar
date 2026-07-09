# 4-3-3-2 Fiscal Routing Grammar

The **4-3-3-2 Fiscal Routing Grammar** is a closure-gated routing grammar for legal-tax AI, accounting compliance, and institutional decision workflows.

It converts open-ended legal, tax, and accounting reasoning into a structured validation process with twelve routing nodes:

- **4 Route Nodes**
- **3 Actor / Subject Nodes**
- **3 Transformation Nodes**
- **2 Trigger Nodes**

The purpose of this grammar is not to make a large language model “smarter” through prompt engineering.

Its purpose is to prevent AI-assisted legal-tax systems from generating conclusions before the evidentiary record, classification route, institutional subject, transformation pattern, and legal trigger have reached structural closure.

In this architecture, AI output is not the first step. AI output is permitted only after routing validation.

---

## Core Architecture

The 4-3-3-2 Fiscal Routing Grammar operates as a control layer between admitted evidence and AI-generated legal-tax output.

```text
[ Admitted Evidence: PJLS ]
          |
          v
[ Classification Drawer: CDM ]
          |
          v
[ 4-3-3-2 Routing Validation ]
          |
          v
[ Closure Status + Routing Status ]
          |
          v
[ AI Output Allowed or Blocked ]
```

The system blocks output where:

```text
closure_status != "closed"
OR
routing_status != "validated"
=
output_blocked = TRUE
```

This creates an **AI Output Brake**.

---

## The 12-Node Structure

### Node 1–4: Route Layer

The first four nodes identify the primary route through which the legal-tax issue must be processed.

In a tax implementation, these may include:

```text
employment
business
property
capital
```

### Node 5–7: Actor / Subject Layer

The next three nodes identify the institutional or legal subject.

In a tax implementation, these may include:

```text
individual
corporation
trust
```

### Node 8–10: Transformation Layer

The next three nodes identify whether a transformation has occurred.

Typical transformation modes include:

```text
timing_shift
character_shift
taxpayer_shift
```

### Node 11–12: Trigger Layer

The final two nodes identify structural triggers.

In a tax implementation, these may include:

```text
change_in_ownership
change_in_use
```

---

## Closure-Gated AI Logic

A legal-tax AI system should not generate a conclusion merely because a language model can produce fluent text.

Instead, the system must first determine whether:

1. the evidence has been admitted;
2. the issue has been placed in the correct classification drawer;
3. the 4-3-3-2 route has been validated;
4. structural closure has been reached;
5. the AI Output Brake has been released.

If these conditions are not met, the system should return:

```text
output_blocked = TRUE
reason = insufficient closure
```

---

## Example: Shareholder Loan Failure Case

A corporation records a payment to a shareholder as:

```text
shareholder loan repayment
```

A conventional AI system may accept that label and generate a tax explanation.

A closure-gated 4-3-3-2 system checks whether the required route is closed, including:

```text
opening shareholder loan balance
general ledger continuity
corporate resolution
bank transaction record
supporting accounting entries
```

If these materials are missing, the system does not generate a tax opinion.

It blocks output.

---

## SQL Control Layer

The grammar can be implemented through relational database constraints.

A simplified control layer may include:

```sql
closure_status TEXT NOT NULL DEFAULT 'open',
routing_status TEXT NOT NULL DEFAULT 'unrouted',

output_blocked BOOLEAN GENERATED ALWAYS AS (
    CASE
        WHEN closure_status = 'closed'
         AND routing_status = 'validated'
        THEN FALSE
        ELSE TRUE
    END
) STORED
```

Safety-critical legal-tax logic should not live only inside a prompt.

A language model may generate persuasive text.

A database constraint does not get persuaded.

---

## Intended Use Cases

The 4-3-3-2 Fiscal Routing Grammar may support:

- legal-tax AI control layers;
- accounting and taxation PaaS systems;
- audit-ready compliance workflows;
- tax classification engines;
- trust and estate routing;
- cross-border tax and entity classification;
- legal AI output governance;
- institutional decision-routing systems.

---

## Relationship to Other Framework Layers

The 4-3-3-2 Fiscal Routing Grammar is part of a broader institutional routing architecture developed by Jim Y. Huang / Yongzhi Huang.

It may operate alongside:

- **PJLS** — Pre-Judgment Logic Shell;
- **CDM** — Classification Drawer Method;
- **Fiscal Geometry**;
- **Structural Fiscalistics**;
- **AI Output Brake**;
- **Closure-Gated Institutional Routing**.

In this architecture:

```text
PJLS controls evidence admission.
CDM controls classification.
4-3-3-2 controls route validation.
The AI Output Brake controls whether generated text is permitted.
```

---

## Technical Status

This repository is an initial public technical specification and minimal implementation environment.

Future versions may include:

```text
schema.sql
4332_schema.json
validator.py
failure-case examples
routing trace examples
audit-ready output examples
```

---

## Intellectual Property & Trademark Notice

“4-3-3-2 GRAMMAR” and “4332” are claimed marks and proprietary intellectual frameworks developed by **Yongzhi Huang / Jim Y. Huang**.

A Canadian trademark application has been filed with the **Canadian Intellectual Property Office (CIPO)**:

- **CIPO Application Number:** 2474260
- **Filed:** 2026-05-08
- **Status:** Formalized; live application awaiting examination
- **Nice Class 42:** Platform as a Service (PaaS) software provider in the fields of accounting and taxation

This repository is provided for academic demonstration, technical discussion, and controlled implementation review.

No license is granted for unauthorized commercial deployment, enterprise tax/accounting PaaS implementation, AI governance productization, or commercial use of the marks “4-3-3-2 GRAMMAR” or “4332” in legal-tax AI systems without prior written authorization from the applicant.

For licensing, collaboration, or commercial implementation inquiries, please contact the author/applicant.

---

## Citation

Suggested citation:

```text
Huang, Jim Y. / Yongzhi Huang. 4-3-3-2 Fiscal Routing Grammar: Technical Specification and Minimal Implementation for Closure-Gated Legal-Tax AI Workflows. GitHub Repository.
```

---

## Author

**Jim Y. Huang / Yongzhi Huang**  
CPA, LLM Tax Law, MBA, TEP  
Doctoral Researcher, University of Toronto  
ORCID: 0009-0009-5688-3993
