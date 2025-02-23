

# **WHAT IS DONE**
- We have already developed the dashboard for all the roles, with the functionalities, using a superadmin that can switch dashboard and pretend to login as user profiles dropdown selector. 
- We have already created roles on our supabase database, and tested the redirects to specific dashboards based on user role. The redirects are working.
- We have implemented role-based authentication and authorization using Supabase Auth
- Created separate dashboard layouts and components for each role:
  - Missionary: Can view donations, submit surplus/leave requests, see reports
  - Finance Officer: Can record offline donations, view recent transactions
  - Campus Director: Shares dashboard with Missionary, additional option to approve/reject requests from missionaries
  - Lead Pastor: Has override capabilities for approvals
  - Superadmin: Full system access and reporting, has dashboard selector

- Built core database tables in Supabase:
  - profiles: Stores user profile data linked to auth.users
  - donor_donations: Records all donation transactions
  - donors: Records all donors
  - surplus_requests: Tracks surplus fund requests
  - leave_requests: Manages missionary leave requests
  - local_churches: Maintains church/location data

- Implemented key features:
  - Role-based dashboard routing and access control
  - Initial reporting capabilities for superadmin
  - Profile management and role assignment
  - Superadmin role-switching functionality for testing

- Set up development environment:
  - Next.js 13+ with App Router
  - Supabase for backend and auth
  - Tailwind CSS for styling
  - TypeScript for type safety
  - Shadcn/UI for components

- Structure of the project
    - global layout
        - sidebar
        - navbar
    - dashboard layout
    - dashboard components
        - missionary
            - DashboardCards.tsx
            - RecentDonations.tsx
            - LeaveRequestModal.tsx
            - SurplusRequestModal.tsx
            - ApprovalTab.tsx
            - RequestHistoryTab.tsx
            - ManualRemittanceWizard.tsx
            - ReportsTab.tsx
        - finance
            - DonationModal.tsx
            - RecentTransactions.tsx
        - lead pastor
            - LeadPastorDashboardClient.tsx
            - LeadPastorSelector.tsx
        - superadmin
            - SuperAdminSidebar.tsx
            - ChurchesList.tsx
            - UsersList.tsx
            - GlobalReportsTab.tsx
                - ChurchesTable.tsx
                - MissionariesTable.tsx
                - PartnersTable.tsx
                - ReportsTabs.tsx
                - TopMetricsCards.tsx
            - SettingsLayout.tsx



*Finance Dashboard:*
    Explanation
    Fetching the Finance Officer’s Profile:
    We query the profiles table for the current user's profile to obtain the local_church_id.

    Filtering Missionary Profiles:
    We then query the profiles table for users with the role "missionary" and add an additional condition .eq('local_church_id', financeProfile?.local_church_id) so that only missionaries belonging to the same local church as the finance officer are fetched.

    Passing the Filtered Data:
    The filtered list is passed as a prop to the DonationModal, which uses it to populate the "Select Missionary" dropdown.

*New Update*
- Changed the way we fetch roles. Implemented a user_roles table to store the roles of the users.
- Finance route already working. Able to login with finance role and able to go straight to finance dashboard. 
- All the other dashboards need editting to apply getUserRole.ts to fetch the correct roles. 
- Recent Transactions Table should be able to see offline transactions made by finance officer only. 
- Added a column on donor_donations table to record who made the transaction. 
- api/donations route is working. Able to post data to the database. 
- DonationModal is working. Able to post data to the database. 
- api/donations updated to include comments. allows online donations.
- ManualRemittanceWizard is working. Able to post data to the database. 

Recent Donations fix:
- updated RLS on donor_donations table:
    drop policy if exists "Allow select donation" on donor_donations;

    create policy "Access based on role and relationships"
    on donor_donations
    for select using (
    exists (select 1 from user_roles where user_id = auth.uid() and role = 'superadmin')
    or donor_donations.missionary_id = auth.uid()
    or exists (
        select 1 from profiles
        where id = auth.uid()
        and role = 'campus_director'
        and donor_donations.missionary_id in (
        select id from profiles
        where campus_director_id = auth.uid()
        )
    )
    or exists (
        select 1 from profiles pastor
        join profiles missionary
        on missionary.local_church_id = pastor.local_church_id
        where pastor.id = auth.uid()
        and pastor.role = 'lead_pastor'
        and donor_donations.missionary_id = missionary.id
    )
    or donor_donations.recorded_by = auth.uid()
    );

    create index idx_donor_donations_missionary on donor_donations(missionary_id);
    create index idx_donor_donations_recorded_by on donor_donations(recorded_by);
    create index idx_profiles_campus_director on profiles(campus_director_id);
    create index idx_profiles_local_church on profiles(local_church_id);

works now. 

errors on missionary dashboard in displaying recent donations fixed. 

changes from usd sign to php sign.

missionary dashboard improved:
- added a new card for current partners and new partners this month. 


**Current Implementation Summary**  
We've restructured the lead pastor approval interface to separate pending and approved requests into distinct sidebar tabs. The "Pending Approvals" tab now exclusively shows actionable requests, while approved items moved to a new "Approved Requests" section. This involved removing dual status tabs (pending/approved) from the approval interface and creating a dedicated component for approved requests.

**Technical Changes Made**  
1. Updated `LeadPastorSidebar.tsx` with new navigation items  
2. Created `ApprovedRequestsTab.tsx` for approved request display  
3. Modified `LeadPastorApprovalTab.tsx` to only handle pending requests  
4. Added state management for request type filtering (leave/surplus)  
5. Fixed missing component imports (Button, Calendar, Wallet icons)  

**Outstanding Issues & Next Steps**  
- TypeScript errors persist in `LeadPastorApprovalCard.tsx` regarding Lodash types and className prop  
- Missing `LeadPastorApprovalCard` import in approval tab components  
- Pagination controls need proper integration with backend data  
- UI requires testing for empty states and edge cases  
- Audit all approval flow components for prop type consistency



**Current Implementation Summary**  
We've implemented a partner tracking system for missionary dashboards that calculates:  
1. **Active Partners**: Unique donors contributing in the current month  
2. **New Partners**: First-time donors this month (no prior contributions)  
Using Set operations on raw donation data from Supabase. The core logic lives in `app/dashboard/missionary/page.tsx`, with UI components in `components/DashboardCards.tsx` and `components/RecentDonations.tsx`.

**Key Challenges & Solutions**  
Initial attempts using Supabase's `distinct` and subqueries produced inaccurate counts due to:  
- Date filtering edge cases (UTC vs local time)  
- Null donor_id handling  
- Complex NOT IN subquery limitations  
The working solution uses manual deduplication via JavaScript Sets after fetching raw donation records, verified through debug logging of actual donor IDs.



**Relevant Implementation Details**  
- **Data Flow**: Fetches all donations → deduplicates via Set → calculates new partners through Set difference  
- **Modified Files**:  
  - `app/dashboard/missionary/page.tsx` (core logic)  
  - UI components for cards/transactions  
  - Global CSS for dashboard styling  
- **Known Limitations**:  
  - Current implementation requires full donation history scans  
  - No caching layer for partner counts  
  - Date calculations use client-side UTC  
- **Validation**: Console logs raw donor IDs and query parameters for verification  
- **Error Handling**: Catches Supabase errors explicitly and throws standardized errors  

change DONORS to PARTNERS
finance recent donations working
fixed manual remittance wizard add new partners bug
added current month tab in reports for missionaries

errors on missionary dashboard when sidebar is hidden.

Campus Missionary Dashbaord
- changed "Reports" to "My reports"
- added "Staff Reports" to campus directors

Lead Pastor dashboard
- added "Staff reports"

Staff Reports are copied from Missionaries Table from superadmin. 

# **Currently working on**




# **WHAT IS NEXT**
- enable RLS for all.



# **BRAIN DUMP**
- add surplus logic sa superadmin reports and to the whole data. 
- trigger surplus compute or something

- try to fix approval logic for surplus and leave request. 
- i think its trying to check who is assigned to the request, instead of just looking at the local church. 

    
superadmin
- list ng lahat ng pending
- list ng lahat ng online donations
- list ng lahat ng offline donations
- pending missionary manual remittance. 
-- pag nag remit si missionary, dapat pending muna until confirmation ni xendit. 
-- so dapat may status ung donor donations 


QR code for missionaries to give to partners

profile customization

MPD WORK stuff. 
- partners na ma-eexpire (2 months reminder ng 1 year commitment about to expire)
- partners na dormant / inactive (di nag bigay last 6 months)

additional MPD leave


campus director dapat may reports din
to check missionary giving status

lead pastor + campus director should have reports
like missionariestable

pastors shoud have delikado list
delinquent list

anything below 15k sagot ni bulacan
