import { useCallback, useEffect, useMemo, useState } from 'react';
import { collection, getDocs, limit, orderBy, query } from 'firebase/firestore';
import { db, isFirebaseConfigured } from '../firebase';

const normalizeUser = (id, data) => ({
  id,
  name: data.name || data.fullName || 'Unknown',
  phone: data.phone || data.phoneNumber || '-',
  gender: data.gender || '-',
  age: data.age || '-',
  city: data.city || data.location || '-',
});

export default function UsersPage() {
  const [search, setSearch] = useState('');
  const [genderFilter, setGenderFilter] = useState('all');
  const [users, setUsers] = useState([]);
  const [status, setStatus] = useState('idle');
  const [error, setError] = useState('');

  const loadUsers = useCallback(async () => {
    if (!isFirebaseConfigured || !db) {
      return;
    }

    try {
      setStatus('loading');
      setError('');

      const usersQuery = query(collection(db, 'users'), orderBy('name'), limit(100));
      const snapshot = await getDocs(usersQuery);
      const mapped = snapshot.docs.map((doc) => normalizeUser(doc.id, doc.data()));

      setUsers(mapped);
      setStatus('success');
    } catch (loadError) {
      setStatus('error');
      setError(
        'Unable to load users list. Ensure users collection exists and that Firestore indexes/permissions are configured.',
      );
    }
  }, []);

  useEffect(() => {
    loadUsers();
  }, [loadUsers]);

  const filteredUsers = useMemo(() => {
    const text = search.trim().toLowerCase();

    return users.filter((user) => {
      const textMatch =
        !text ||
        user.name.toLowerCase().includes(text) ||
        user.phone.toLowerCase().includes(text) ||
        user.id.toLowerCase().includes(text);

      const genderMatch =
        genderFilter === 'all' || user.gender.toLowerCase() === genderFilter.toLowerCase();

      return textMatch && genderMatch;
    });
  }, [search, users, genderFilter]);

  return (
    <section>
      <div className="toolbar">
        <h2 className="section-title" style={{ margin: 0 }}>Users</h2>
        <button className="button" type="button" onClick={loadUsers}>
          Refresh Users
        </button>
      </div>

      <div className="toolbar">
        <input
          className="input"
          id="user-search"
          type="text"
          value={search}
          onChange={(event) => setSearch(event.target.value)}
          placeholder="Search by name / phone / id"
        />

        <select
          className="select"
          value={genderFilter}
          onChange={(event) => setGenderFilter(event.target.value)}
        >
          <option value="all">All genders</option>
          <option value="male">Male</option>
          <option value="female">Female</option>
          <option value="other">Other</option>
        </select>

        <span className="muted">Showing: {filteredUsers.length}</span>
      </div>

      {status === 'loading' && <p className="muted">Loading users...</p>}
      {status === 'error' && <p className="error">{error}</p>}
      {status === 'success' && filteredUsers.length === 0 && <p className="muted">No users found.</p>}

      {filteredUsers.length > 0 && (
        <div className="table-wrap">
          <table>
            <thead>
              <tr>
                <th>Name</th>
                <th>Phone</th>
                <th>Gender</th>
                <th>Age</th>
                <th>City</th>
                <th>User ID</th>
              </tr>
            </thead>
            <tbody>
              {filteredUsers.map((user) => (
                <tr key={user.id}>
                  <td>{user.name}</td>
                  <td>{user.phone}</td>
                  <td>{user.gender}</td>
                  <td>{user.age}</td>
                  <td>{user.city}</td>
                  <td>{user.id}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}
    </section>
  );
}
