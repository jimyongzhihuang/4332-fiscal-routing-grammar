"""
4-3-3-2 Fiscal Routing Grammar
Minimal validator for closure-gated legal-tax AI workflows

Author: Jim Y. Huang / Yongzhi Huang
"""

from __future__ import annotations

import json
from pathlib import Path
from typing import Any, Dict


REQUIRED_EVIDENCE_STATUS = "admitted"
REQUIRED_CLASSIFICATION_STATUS = "classified"
REQUIRED_CLOSURE_STATUS = "closed"
REQUIRED_ROUTING_STATUS = "validated"


def validate_4332_case(case_data: Dict[str, Any]) -> Dict[str, Any]:
    """
    Validate whether a 4-3-3-2 legal-tax routing case has reached structural closure.

    This validator does not produce a tax opinion.
    It only determines whether AI-assisted legal-tax output should be allowed or blocked.
    """

    pjls = case_data.get("pjls_evidence_review", {})
    cdm = case_data.get("cdm_classification", {})
    closure = case_data.get("closure_control", {})

    evidence_status = pjls.get("evidence_status")
    classification_status = cdm.get("classification_status")
    closure_status = closure.get("closure_status")
    routing_status = closure.get("routing_status")

    failures = []

    if evidence_status != REQUIRED_EVIDENCE_STATUS:
        failures.append(
            f"Evidence status is '{evidence_status}', not '{REQUIRED_EVIDENCE_STATUS}'."
        )

    if classification_status != REQUIRED_CLASSIFICATION_STATUS:
        failures.append(
            f"Classification status is '{classification_status}', not '{REQUIRED_CLASSIFICATION_STATUS}'."
        )

    if closure_status != REQUIRED_CLOSURE_STATUS:
        failures.append(
            f"Closure status is '{closure_status}', not '{REQUIRED_CLOSURE_STATUS}'."
        )

    if routing_status != REQUIRED_ROUTING_STATUS:
        failures.append(
            f"Routing status is '{routing_status}', not '{REQUIRED_ROUTING_STATUS}'."
        )

    output_blocked = len(failures) > 0

    return {
        "case_id": case_data.get("case_id"),
        "audit_trace_id": case_data.get("audit_trace_id"),
        "output_blocked": output_blocked,
        "decision": "BLOCK_OUTPUT" if output_blocked else "ALLOW_OUTPUT",
        "failures": failures,
        "message": (
            "AI output is blocked because structural closure has not been reached."
            if output_blocked
            else "AI output may be generated, subject to professional review."
        ),
    }


def load_case(path: str | Path) -> Dict[str, Any]:
    """Load a JSON routing case file."""

    with open(path, "r", encoding="utf-8") as file:
        return json.load(file)


def main() -> None:
    """
    Example commands:

        python validator.py ../examples/shareholder_loan_failure.json
        python validator.py ../examples/validated_routing_success.json
    """

    import argparse

    parser = argparse.ArgumentParser(
        description="Validate a 4-3-3-2 closure-gated legal-tax routing case."
    )
    parser.add_argument("case_file", help="Path to a JSON case file.")
    args = parser.parse_args()

    case_data = load_case(args.case_file)
    result = validate_4332_case(case_data)

    print(json.dumps(result, indent=2))


if __name__ == "__main__":
    main()
