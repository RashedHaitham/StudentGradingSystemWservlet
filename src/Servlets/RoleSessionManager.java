package Servlets;
import java.util.concurrent.atomic.AtomicInteger;
import Model.Role;
public class RoleSessionManager {
    private static final int MAX_ACTIVE_SESSIONS = 10;
    private static final AtomicInteger activeAdminSessions = new AtomicInteger(0);
    private static final AtomicInteger activeInstructorSessions = new AtomicInteger(0);
    private static final AtomicInteger activeStudentSessions = new AtomicInteger(0);

    public static synchronized boolean canCreateSession(Role role) {
        switch (role) {
            case ADMIN:
                return activeAdminSessions.get() < MAX_ACTIVE_SESSIONS;
            case INSTRUCTOR:
                return activeInstructorSessions.get() < MAX_ACTIVE_SESSIONS;
            case STUDENT:
                return activeStudentSessions.get() < MAX_ACTIVE_SESSIONS;
            default:
                return false;
        }
    }

    public static synchronized void incrementSessionCounter(Role role) {
        switch (role) {
            case ADMIN:
                activeAdminSessions.incrementAndGet();
                break;
            case INSTRUCTOR:
                activeInstructorSessions.incrementAndGet();
                break;
            case STUDENT:
                activeStudentSessions.incrementAndGet();
                break;
        }
    }

    public static synchronized void decrementSessionCounter(Role role) {
        switch (role) {
            case ADMIN:
                activeAdminSessions.decrementAndGet();
                break;
            case INSTRUCTOR:
                activeInstructorSessions.decrementAndGet();
                break;
            case STUDENT:
                activeStudentSessions.decrementAndGet();
                break;
        }
    }
}
