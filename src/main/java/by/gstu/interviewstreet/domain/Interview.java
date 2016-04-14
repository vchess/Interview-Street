package by.gstu.interviewstreet.domain;

import by.gstu.interviewstreet.web.util.DateUtils;
import com.google.gson.annotations.Expose;
import org.hibernate.annotations.Generated;
import org.hibernate.annotations.GenerationTime;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "interviews")
public class Interview implements Serializable {

    private static final String LOCK_ICON = "lock";
    private static final String LOCK_OPEN_ICON = "lock_open";

    private static final String LOCK_ICON_TITLE = "Анкета закрыта для прохождения";
    private static final String LOCK_OPEN_ICON_TITLE = "Анкета открыта для прохождения";

    @Id
    @Expose
    @GeneratedValue
    @Column(name = "id")
    private int id;

    @Expose
    @NotEmpty
    @Length(min = 5, max = 60)
    @Column(name = "name", length = 60)
    private String name;

    @Expose
    @NotEmpty
    @Length(min = 3, max = 70)
    @Column(name = "description", length = 70)
    private String description;

    @Generated(GenerationTime.INSERT)
    @Length(min = 0, max = 500)
    @Column(name = "introductory_text", length = 500)
    private String introductoryText;

    @Expose
    @Length(max = 65)
    @Column(name = "goal", length = 65)
    private String goal;

    @Expose
    @Length(max = 25)
    @Column(name = "audience", length = 25)
    private String audience;

    @Expose
    @Column(name = "hide")
    private boolean hide;

    @Generated(GenerationTime.ALWAYS)
    @Column(name = "placement_date")
    private Date placementDate;

    @Expose
    @NotNull
    @Temporal(TemporalType.DATE)
    @Column(name = "end_date")
    private Date endDate;

    @NotNull
    @Column(name = "hash", length = 45)
    private String hash;

    @NotNull
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User creator;

    @Expose
    @NotNull
    @ManyToOne
    @JoinColumn(name = "type_id")
    private InterviewType type;

    @OneToMany(mappedBy = "interview", cascade = CascadeType.ALL)
    private Set<Question> questions = new HashSet<>();

    public Interview() {
    }

    public boolean getIsNew() {
        return DateUtils.isToday(placementDate);
    }

    public String getLockIcon() {
        return hide ? LOCK_ICON : LOCK_OPEN_ICON;
    }

    public String getTitle() {
        return hide ? LOCK_ICON_TITLE : LOCK_OPEN_ICON_TITLE;
    }

    public String getFormatPlacementDate() {
        return DateUtils.YYYY_MM_DD.format(placementDate);
    }

    public String getFormatEndDate() {
        return DateUtils.YYYY_MM_DD.format(endDate);
    }

    //region Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getGoal() {
        return goal;
    }

    public void setGoal(String goal) {
        this.goal = goal;
    }

    public String getAudience() {
        return audience;
    }

    public void setAudience(String audience) {
        this.audience = audience;
    }

    public boolean getHide() {
        return hide;
    }

    public void setHide(boolean hide) {
        this.hide = hide;
    }

    public Date getPlacementDate() {
        return placementDate;
    }

    public void setPlacementDate(Date placementDate) {
        this.placementDate = placementDate;
    }

    public Date getEndDate() {
        if (DateUtils.isMoreThanToday(endDate)) {
            return endDate;
        }
        return DateUtils.getTomorrow();
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public Set<Question> getQuestions() {
        return questions;
    }

    public void setQuestions(Set<Question> questions) {
        this.questions = questions;
    }

    public User getCreator() {
        return creator;
    }

    public void setCreator(User creator) {
        this.creator = creator;
    }

    public InterviewType getType() {
        return type;
    }

    public void setType(InterviewType type) {
        this.type = type;
    }

    public String getHash() {
        return hash;
    }

    public void setHash(String hash) {
        this.hash = hash;
    }

    public String getIntroductoryText() {
        return introductoryText;
    }

    public void setIntroductoryText(String introductoryText) {
        this.introductoryText = introductoryText;
    }

    //endregion

    @Override
    public String toString() {
        return "Interview{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", goal='" + goal + '\'' +
                ", audience='" + audience + '\'' +
                ", hide=" + hide +
                ", placementDate=" + placementDate +
                ", endDate=" + endDate +
                ", hash='" + hash + '\'' +
                ", type=" + type +
                ", creator=" + creator +
                '}';
    }
}
