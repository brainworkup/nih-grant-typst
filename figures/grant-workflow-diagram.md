# NIH Grant Workflow: Template to Submission

```mermaid
flowchart TD
    A[Start: Need NIH Grant] --> B[Run quick_start.py]
    B --> C{Select Grant Type}
    C --> D[R01: Major Research<br/>12-page Research Strategy]
    C --> E[R03: Small Grant<br/>6-page Research Strategy]
    C --> F[R21: Exploratory<br/>6-page Research Strategy]
    
    D --> G[Enter Project Details]
    E --> G
    F --> G
    
    G --> H[Template Copied to<br/>my_grants/project_name/]
    
    H --> I[Edit Core Documents]
    I --> J[Specific Aims<br/>1 page]
    I --> K[Research Strategy<br/>6-12 pages]
    I --> L[Biosketch<br/>5 pages per person]
    I --> M[Budget<br/>& Justification]
    
    J --> N{Content Review}
    K --> N
    L --> N
    M --> N
    
    N -->|Needs Work| O[Revise Content]
    O --> I
    
    N -->|Ready| P[Compile with Typst]
    P --> Q[Generate PDF]
    Q --> R{Quality Check}
    
    R -->|Format Issues| S[Fix Formatting]
    S --> P
    
    R -->|Content Issues| T[Edit Content]
    T --> I
    
    R -->|Ready| U[Internal Review]
    U --> V{Feedback}
    
    V -->|Major Changes| W[Substantial Revisions]
    W --> I
    
    V -->|Minor Changes| X[Polish & Final Edits]
    X --> Y[Final Compilation]
    
    V -->|Approved| Y
    
    Y --> Z[Submission-Ready PDF]
    Z --> AA[Submit to NIH]
    
    style A fill:#e1f5fe
    style AA fill:#c8e6c9
    style C fill:#fff3e0
    style N fill:#fce4ec
    style R fill:#fce4ec
    style V fill:#fce4ec
    style Z fill:#c8e6c9
```

## Workflow Phases

### 1. **Template Selection & Setup**
- Use `quick_start.py` for guided setup
- Choose appropriate grant mechanism (R01, R03, R21)
- Configure project details and folder structure

### 2. **Content Development**
- **Specific Aims**: Clear, testable hypotheses
- **Research Strategy**: Significance, innovation, approach
- **Biosketch**: Key personnel qualifications
- **Budget**: Detailed cost breakdown

### 3. **Review & Revision Cycles**
- **Content Review**: Scientific merit, clarity, feasibility
- **Format Check**: NIH guidelines compliance
- **Internal Review**: Institutional feedback

### 4. **Final Preparation**
- Polish language and presentation
- Ensure all requirements met
- Generate final submission PDF

## Key Checkpoints

| Phase | Checkpoint | Action Required |
|-------|------------|----------------|
| Setup | Template copied | Verify all files present |
| Development | First draft complete | Internal content review |
| Compilation | PDF generated | Format compliance check |
| Review | Feedback received | Address all comments |
| Submission | Final PDF | Upload to NIH system |

## Quality Gates

- ✅ **Page limits respected** (varies by grant type)
- ✅ **All required sections included**
- ✅ **References properly formatted**
- ✅ **Figures and tables clear and labeled**
- ✅ **Budget matches narrative**
- ✅ **Biosketches current and relevant**
