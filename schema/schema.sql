-- 4-3-3-2 Fiscal Routing Grammar
-- Minimal SQL control schema for closure-gated legal-tax AI workflows
-- Author: Jim Y. Huang / Yongzhi Huang

CREATE TABLE fiscal_routing_engine (
    case_id TEXT PRIMARY KEY,
    audit_trace_id TEXT NOT NULL UNIQUE,

    -- ------------------------------------------------------------
    -- Node 1-4: Route Layer
    -- ------------------------------------------------------------
    -- In this tax implementation, the route layer identifies the
    -- primary income or fiscal rail through which the case is routed.
    -- ------------------------------------------------------------

    income_rail TEXT NOT NULL,

    CONSTRAINT chk_income_rail
        CHECK (
            income_rail IN (
                'employment',
                'business',
                'property',
                'capital'
            )
        ),

    -- ------------------------------------------------------------
    -- Node 5-7: Actor / Subject Layer
    -- ------------------------------------------------------------
    -- The actor layer identifies the legal-tax subject.
    -- ------------------------------------------------------------

    tax_subject TEXT NOT NULL,

    CONSTRAINT chk_tax_subject
        CHECK (
            tax_subject IN (
                'individual',
                'corporation',
                'trust'
            )
        ),

    -- ------------------------------------------------------------
    -- Node 8-10: Transformation Layer
    -- ------------------------------------------------------------
    -- These fields detect whether the case involves a shift in timing,
    -- legal/fiscal character, or taxpayer identity.
    -- ------------------------------------------------------------

    has_timing_shift BOOLEAN NOT NULL DEFAULT FALSE,
    has_character_shift BOOLEAN NOT NULL DEFAULT FALSE,
    has_taxpayer_shift BOOLEAN NOT NULL DEFAULT FALSE,

    -- ------------------------------------------------------------
    -- Node 11-12: Trigger Layer
    -- ------------------------------------------------------------
    -- These fields detect whether structural triggers are present.
    -- ------------------------------------------------------------

    trigger_ownership_change BOOLEAN NOT NULL DEFAULT FALSE,
    trigger_use_change BOOLEAN NOT NULL DEFAULT FALSE,

    -- ------------------------------------------------------------
    -- Evidence and Classification Control
    -- ------------------------------------------------------------

    evidence_status TEXT NOT NULL DEFAULT 'unreviewed',

    CONSTRAINT chk_evidence_status
        CHECK (
            evidence_status IN (
                'unreviewed',
                'insufficient',
                'admitted'
            )
        ),

    classification_status TEXT NOT NULL DEFAULT 'unclassified',

    CONSTRAINT chk_classification_status
        CHECK (
            classification_status IN (
                'unclassified',
                'misclassified',
                'classified'
            )
        ),

    -- ------------------------------------------------------------
    -- Closure and Routing Control
    -- ------------------------------------------------------------

    closure_status TEXT NOT NULL DEFAULT 'open',

    CONSTRAINT chk_closure_status
        CHECK (
            closure_status IN (
                'open',
                'insufficient_evidence',
                'closed'
            )
        ),

    routing_status TEXT NOT NULL DEFAULT 'unrouted',

    CONSTRAINT chk_routing_status
        CHECK (
            routing_status IN (
                'unrouted',
                'invalid_path',
                'validated'
            )
        ),

    -- ------------------------------------------------------------
    -- AI Output Brake
    -- ------------------------------------------------------------
    -- This generated column acts as the physical output brake.
    -- AI output is blocked unless evidence, classification, closure,
    -- and routing have all reached the required state.
    -- ------------------------------------------------------------

    output_blocked BOOLEAN GENERATED ALWAYS AS (
        CASE
            WHEN evidence_status = 'admitted'
             AND classification_status = 'classified'
             AND closure_status = 'closed'
             AND routing_status = 'validated'
            THEN FALSE
            ELSE TRUE
        END
    ) STORED,

    -- ------------------------------------------------------------
    -- Optional Explanation Field
    -- ------------------------------------------------------------

    blocked_reason TEXT,

    -- ------------------------------------------------------------
    -- Created Timestamp
    -- ------------------------------------------------------------

    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
);
