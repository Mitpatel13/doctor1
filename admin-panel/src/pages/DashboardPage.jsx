import { useCallback, useEffect, useState } from 'react';
import { collection, getCountFromServer, query, where } from 'firebase/firestore';
import { db, isFirebaseConfigured } from '../firebase';

const todayStart = () => {
  const now = new Date();
  return new Date(now.getFullYear(), now.getMonth(), now.getDate());
};

export default function DashboardPage() {
  const [stats, setStats] = useState({
    totalUsers: '--',
    dailyActiveUsers: '--',
    newMatchesToday: '--',
  });
  const [status, setStatus] = useState('idle');
  const [error, setError] = useState('');

  const loadStats = useCallback(async () => {
    if (!isFirebaseConfigured || !db) {
      return;
    }

    try {
      setStatus('loading');
      setError('');
      const start = todayStart();

      const [usersSnapshot, activeSnapshot, matchesSnapshot] = await Promise.all([
        getCountFromServer(collection(db, 'users')),
        getCountFromServer(query(collection(db, 'users'), where('lastActiveAt', '>=', start))),
        getCountFromServer(query(collection(db, 'matches'), where('createdAt', '>=', start))),
      ]);

      setStats({
        totalUsers: usersSnapshot.data().count,
        dailyActiveUsers: activeSnapshot.data().count,
        newMatchesToday: matchesSnapshot.data().count,
      });
      setStatus('success');
    } catch (loadError) {
      setStatus('error');
      setError(
        'Unable to load dashboard stats. Verify Firestore collections and timestamp fields (users.lastActiveAt, matches.createdAt).',
      );
    }
  }, []);

  useEffect(() => {
    loadStats();
  }, [loadStats]);

  return (
    <section>
      <div className="toolbar">
        <h2 className="section-title" style={{ margin: 0 }}>Dashboard</h2>
        <button className="button" type="button" onClick={loadStats}>
          Refresh Metrics
        </button>
      </div>

      <div className="grid">
        <article className="card">
          <h3>Total Users</h3>
          <div className="metric">{stats.totalUsers}</div>
        </article>
        <article className="card">
          <h3>Daily Active Users</h3>
          <div className="metric">{stats.dailyActiveUsers}</div>
        </article>
        <article className="card">
          <h3>New Matches Today</h3>
          <div className="metric">{stats.newMatchesToday}</div>
        </article>
      </div>

      {status === 'loading' && <p className="muted">Loading latest metrics...</p>}
      {status === 'error' && <p className="error">{error}</p>}
    </section>
  );
}
